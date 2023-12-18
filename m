Return-Path: <linux-kernel+bounces-4130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7425817833
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB51F22707
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86985A84B;
	Mon, 18 Dec 2023 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TkuZVO+M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD11E486
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702919479; bh=mM8mzZFIzVQzxKZxLzuV90iLFrkQP1n0wMUWBO3W3Ug=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TkuZVO+MhLdUXjzUH0m1kGx1ymR8oGmkl1Hyxwy/2zae/cC1FR6QCJJdpqZ6BGbvpwmgyMYlCQC5DR1OMlGopGf4tGNUxakHI+NdSUpY2w2XJNBJMOi25PfejQ6Xo7xBWgrSLuXPmGJ+2wvwrL9Srh5WIpZZjDNoxqwU0sCCTno6qa6gT2yd+Y1pG+cG9OX8KZx8sSx9iyuS+228WuNVEYxWu8xhj62T6sUbwqPDK7ywWRM4FOtIg5FZVlLmrnOn5zgpKEddeShP6WJ4ibxmv0viNot46tqNwvQX2GS1BWG9M7NIpdCIZJyHFaKoZCzbt77+t1lcOBFAqL412G13EQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702919479; bh=pLxLpQyUNbuE9aCPgLi+VWU1o6VABSREnHXbjn7ieMe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GfkGSlvhOihNd8l2A+xbHN7xTSSsaOg7rMtNriNtIhKhacJRoy7Q6YjZSUBTAsagG5KCcJcAiyNQpJZPGKF86GHsdDzT5Sb2xNfPextX39GUTlN2d0oa20YNcvtnYVFv8aVk0FI0o4iVq/3u5m3TF+/D+8F2hkj9YwqxhozXF20uC2FgS9HEvlBU4tcvWgPjnQ2721UnMwuogNTecggJlFwXYE5H5vXTen6KeZmfOIjROOQ4InqN+BaCmdKZs+GI3VGfrpnCh3spN9KUwCbnLZ7kByNkiYG1QfH3A/eeo0lkgn4+wy2yEfCMv6CH8rPTDPla44c6oz1FRUSd0WF4zA==
X-YMail-OSG: hd_1o48VM1nmOcKAJrPSVxlvFGzWGmNIScEYWrY.FQV6yVUm27gobrgb10rd09.
 D80MlhJXWiwF1WmP9dEkcbeGYYbyZZ3R_MKV_4FjQYSFA8zT.aH8KKo6EQUZSWLWe2eyqfzg9onB
 R4KaDPcr.edZzkTmVvL7OqZRDFnm_CJYbf9wmjg03dJBIRVynCEmmCSf0n63Rrf._9E1nMU919aE
 Q1h1rBdghlqOKxyI.vwn0V9No_TL7tnBKGBCYYmEin4XGnbekDFIwksxdE..RHDQu2Uz3FLgLg9R
 nTq0OshFewVMAJCP6IRt8k6rBEyUN4vDp80z2GFSpXygAq2bkVpN6IFLrM1_BQVOF9rJN3zTNmDz
 LukZYNWpUxwxvVYKqGdkMqpCFhNyFGqA1xrZ71a2SaFamSyAAI2y56tGtp64EyrQ9.UmZA1lyNyc
 rgzN1JVn4O9cNOD7ok_saag7d9ZFUrtoXU01Mz7DjE4EqSCI64I7WStfhEFophhmvg99et993B9Q
 eFPyjYUf0b3T56ofv_RxvY8qdkdH6XxYx8b70UcYM9Ahavn0H98ZNT1BVEXL2gIoGU9Khb.n2NhF
 IkhbJBOo6jwnbIih.fH.vCM30dFTbXfawCvnrtuxT9aaSIQZtzWhbEPclBA.Dmq57OHWAr_A.R22
 FtI2vK1vY.RQkT0KejNOSbnjIkFGCaV0DO6tbLO5A1e90qwbw5gYRA1dSxmFoTx2k0iYQWT6DIrW
 wIU0OT0JLaBOtc49BNvqzfNSRJ9AvGlmmYB4XGTCKRGS52IbfSMJBNM8Hmy6wm9qeI7l8C3692CE
 xL9RYPFtbSaDlYNQUuAS0eLx_CmUZd9Qo9gNF28XpEGVXTcjq6eGlo_4KZokydsBNOifjA3RYwHh
 dnE_hcio4TcdZtFT0P7SZAVMoL.hIKmhd32GAnNYDDTdJuR0_JWVlDtcJ9I3s6BW8gYRq5YxPdRr
 XLD8m3b8ZSeMJ6yEExDKXfdV9exyHy21_ts48fr22QVkKWES86Fw2.Hc6WXN_w8E45dWtrY2KI74
 qWxDxZuEPL3p.cbguHz7O5m3jXqj5KyPnQwtn4KbyH2Xt0Be4RHDlXk38AxtK60mol1IHarxCTtA
 9cwbR31dmfPV0bZjrF51RF6l2AyNOu_hzUWsjwsRFcnzhCZk8Yp0OuBSuvcdsXW5IPhPgTc4RVNf
 Vji4OZ3l.6LpsrtsAj7Hln5mg4RXbboVIFk65GP7dwvXIjfJ5prA5UUv7DHmoC.FZ_QFqAI0_0uY
 9ko4yR6OEr5iX3nYnVTRHq4OI..BMh2nSttpskcMAKWNZ6VjllNt5TYmY.1Tjw8bsCQndvp2ANJc
 fln7e8ZPrWhVdfy7q6RrglQ5DyXUkHmm.SAsjeHQKZHQRISwoWLu6Z_JOb5lyy105I0N9FPE7AL4
 zDt52.2F_9uC1X8jcdbB6CYlB7g_QoF2F2GgyxvHt9OnEtQf1qcYirY_LWQhX26Kred9_fceBMqZ
 nnVtybTx6gHmqcOCiZwZ7_CGxdLFtnm207TcOvkVvNb7JKwrEcrsSCkLNSsYSGWjjAqK_.FTXOEN
 Acr8xnlOc_qxmEYoZv3rI8SEHSUjS8ZXi0ZweLoIDW1jHwjSlKxkOxOvdNX0fgz1s8tYIRb.bxWz
 y.aO7sYgToGRtFb520wfl8.MVq_KChy8_zW5cY7WxUqdQCmYbRw57QFNXVkT7Xc0_gYJLbj1q8ug
 sRGQExSwkyu6xfRQ1E7DEHDZP5knUJmC4XoXCHTT7RGPmbucT7U_oQ.u24nJ0WFepza0DIrFenQT
 5QbNLFs709FL5Ui0NY85gAjpsreeUpSPNP0ToJpypc5nhtdXqb3xUvwSMZ7sjKwyDk3jeu63FmPk
 N_QknxnCpMsl3ucPNM3nnKCmllMjmtFIFN2onvx6CLqaLXjf4IEJVxydHojdSb2yndQ2OjYgjpfC
 ud9tryiZbne.YwLrt3DOnFyMwqbC7JdvuoCwz3hc1iJXGcLQoXjm9a4Gztipm9vHMv67LVFC5Agc
 rY0QnPUPBTokLX95k_3D7Xb9q64G8ev.3_o2d7lL_UJ4B1PIZ85P4pLnYb9CSkgcpvOwJ9s.KYOW
 .zsK5XRGx.SwS2DSSv_Cp3wVOquv43ksESMjDzABuuyj9Mm8htCKLJseEn4GN7YIy_MPcpg5HFe8
 SbSdAlIMrVOfEsE2uc05tTi.JuBmbyoIbUPkzAuOJQnuf1k5ydqDJxRiizdf_lJi2A4Do_Ikfg9t
 0h7OyZRizaPqxHO7k2T6f.EjCWyNSdSJ.wBiiXA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6dce1582-840c-4dd9-93c1-da1ebc2edce3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Dec 2023 17:11:19 +0000
Received: by hermes--production-gq1-6949d6d8f9-7dnvp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e806ab30060b31f192cc526ebc8a5786;
          Mon, 18 Dec 2023 17:11:17 +0000 (UTC)
Message-ID: <6dce3020-14f0-471b-9b6a-c9dc761cfa19@schaufler-ca.com>
Date: Mon, 18 Dec 2023 09:11:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] SELinux: Introduce security_file_ioctl_compat hook
Content-Language: en-US
To: Alfred Piccioni <alpic@google.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>
Cc: stable@vger.kernel.org, selinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20231218141645.2548743-1-alpic@google.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231218141645.2548743-1-alpic@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/18/2023 6:16 AM, Alfred Piccioni wrote:

> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
>
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
>
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
>
> This patch introduces a new hook, security_file_ioctl_compat, that is
> called from the compat ioctl syscal. All current LSMs have been changed
> to support this hook.
>
> Reviewing the three places where we are currently using
> security_file_ioctl, it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
>
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Cc: stable@vger.kernel.org

This *really* needs to go the the LSM email list:
	linux-security-module@vger.kernel.org

> ---
>  fs/ioctl.c                    |  3 +--
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 17 +++++++++++++++++
>  security/selinux/hooks.c      | 26 ++++++++++++++++++++++++++
>  security/smack/smack_lsm.c    |  1 +
>  security/tomoyo/tomoyo.c      |  1 +
>  7 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f5fd99d6b0d4..76cf22ac97d7 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -920,8 +920,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  	if (!f.file)
>  		return -EBADF;
>  
> -	/* RED-PEN how should LSM module know it's handling 32bit? */
> -	error = security_file_ioctl(f.file, cmd, arg);
> +	error = security_file_ioctl_compat(f.file, cmd, arg);
>  	if (error)
>  		goto out;
>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ac962c4cb44b..626aa8cf930d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -171,6 +171,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> +LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
> +	 unsigned long arg)

Please add a flags parameter to file_ioctl() rather than a new hook.

>  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
>  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
>  	 unsigned long prot, unsigned long flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f16eecde00b..22a82b7c59f1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -389,6 +389,7 @@ int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg);
>  int security_mmap_file(struct file *file, unsigned long prot,
>  			unsigned long flags);
>  int security_mmap_addr(unsigned long addr);
> @@ -987,6 +988,12 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
>  	return 0;
>  }
>  
> +static inline int security_file_ioctl_compat(struct file *file, unsigned int cmd,
> +				      unsigned long arg)
> +{
> +	return 0;
> +}
> +
>  static inline int security_mmap_file(struct file *file, unsigned long prot,
>  				     unsigned long flags)
>  {
> diff --git a/security/security.c b/security/security.c
> index 23b129d482a7..5c16ffc99b1e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2648,6 +2648,23 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  }
>  EXPORT_SYMBOL_GPL(security_file_ioctl);
>  
> +/**
> + * security_file_ioctl_compat() - Check if an ioctl is allowed in 32-bit compat mode
> + * @file: associated file
> + * @cmd: ioctl cmd
> + * @arg: ioctl arguments
> + *
> + * Compat version of security_file_ioctl() that correctly handles 32-bit processes
> + * running on 64-bit kernels.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
> +}
> +EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
> +
>  static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
>  {
>  	/*
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2aa0e219d721..de96d156e6ea 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3731,6 +3731,31 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>  	return error;
>  }
>  
> +static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	// If we are in a 64-bit kernel running 32-bit userspace, we need to make
> +	// sure we don't compare 32-bit flags to 64-bit flags.
> +	switch (cmd) {
> +	case FS_IOC32_GETFLAGS:
> +		cmd = FS_IOC_GETFLAGS;
> +		break;
> +	case FS_IOC32_SETFLAGS:
> +		cmd = FS_IOC_GETFLAGS;
> +		break;
> +	case FS_IOC32_GETVERSION:
> +		cmd = FS_IOC_GETVERSION;
> +		break;
> +	case FS_IOC32_SETVERSION:
> +		cmd = FS_IOC_SETVERSION;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return selinux_file_ioctl(file, cmd, arg);
> +}
> +
>  static int default_noexec __ro_after_init;
>  
>  static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
> @@ -7036,6 +7061,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(file_permission, selinux_file_permission),
>  	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
>  	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
> +	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
>  	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
>  	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
>  	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 65130a791f57..1f1ea8529421 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4973,6 +4973,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>  
>  	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
>  	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
> +	LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
>  	LSM_HOOK_INIT(file_lock, smack_file_lock),
>  	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
>  	LSM_HOOK_INIT(mmap_file, smack_mmap_file),
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 25006fddc964..298d182759c2 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -568,6 +568,7 @@ static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
>  	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
>  	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
> +	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
>  	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
>  	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
>  	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
>
> base-commit: 196e95aa8305aecafc4e1857b7d3eff200d953b6

