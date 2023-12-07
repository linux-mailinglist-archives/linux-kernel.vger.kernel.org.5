Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863C6808819
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379443AbjLGMhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLGMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:37:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C9510E0;
        Thu,  7 Dec 2023 04:37:53 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d045097b4cso6222915ad.0;
        Thu, 07 Dec 2023 04:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952672; x=1702557472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YA2HL8V98aG8WbRm7XDMexYzsiasMgr7pjivJNkp9ro=;
        b=H9qyI7yFw9c+n7wXeHEQ4OFebmfqLilpHfAvawoIK6/AqT2kA/Pf5bgxEVKLkh/r5b
         QdA7GDIt8IT/jkbwRyDpu6NbMDVbN0h2k0v1vy1AOVRcWJEn+gGTScqrvqqeBs+KbjYP
         u4/U7k9G/qFzbFtwIvEMx+iK4TN8Bhd0uX54oIns1Ug/8PpiqlxTEc71d6pWIDTVxO0K
         MnrtnMWDGYxb/oNpoQywVuhpvOf18hDKC5y0sLgnRyxRdGgH6u7M3FEvytm1xyj/ZP/f
         ww00/eMIy4BjADWdToZIlw+TBDQ35S+22oDocqc34CrvBIiMYs1TXkn2gPO7LxhUvXQe
         vstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952672; x=1702557472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YA2HL8V98aG8WbRm7XDMexYzsiasMgr7pjivJNkp9ro=;
        b=J4wPtndzgxXRSAZG9Peb7GkVvNLXrtK5lAzB8Rc0VOwLlswFFYizGqQO7kQjqaCFSM
         ZtnmAElUr22B0jBzE8VoDtTU5IszX3GFCI2REpd6l1FWylNj9OiV2uburbAZ0KbBez/7
         Ex39i8r9N2vgZ+qgp/6Biw8fq1Xd9cevydhn14qANeJSlrmlcCqjlsdeVyAOsporPx2J
         tTVQqZebt6bvWMVOzmtpiqI+P/jZJB+xkwz0vL2Qi7X644Jqf8Fiu0+widVFRUHHjpTU
         e7R8hevfdbgusy9YKMGWGGpx7DkUsWNYfvLoPG4jwvKHTC1UpT9rFLgww5lEbs9n9Noe
         yiyw==
X-Gm-Message-State: AOJu0YwvPeMMvkM+7zRf3DYYsaYWQj3fXxRNxws9Z3bAcha9ii4Y66U5
        ifJIqJO6pbMKmlmXsY9QIHc=
X-Google-Smtp-Source: AGHT+IGSNujGTBVvhbTxR98+zr8fuG84uHyu+RmlfNozJRC4tTWCKpkorARfzDR3yVQ3I6jz43GAbg==
X-Received: by 2002:a17:903:2647:b0:1d0:a9fa:592d with SMTP id je7-20020a170903264700b001d0a9fa592dmr1961505plb.118.1701952672288;
        Thu, 07 Dec 2023 04:37:52 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001d075e847d5sm1318881plb.44.2023.12.07.04.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:37:51 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id D077810418A9A; Thu,  7 Dec 2023 19:37:48 +0700 (WIB)
Date:   Thu, 7 Dec 2023 19:37:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexander Graf <graf@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan H =?utf-8?B?LiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>
Subject: Re: [PATCH v2] initramfs: Expose retained initrd as sysfs file
Message-ID: <ZXG8nEEMqorxeM3E@archie.me>
References: <20231206213323.78233-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yzFdKNTogRVNR2zX"
Content-Disposition: inline
In-Reply-To: <20231206213323.78233-1-graf@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzFdKNTogRVNR2zX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 09:33:23PM +0000, Alexander Graf wrote:
> diff --git a/Documentation/ABI/testing/sysfs-firmware-initrd b/Documentat=
ion/ABI/testing/sysfs-firmware-initrd
> new file mode 100644
> index 000000000000..20bf7cf77a19
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-initrd
> @@ -0,0 +1,8 @@
> +What:		/sys/firmware/initrd
> +Date:		December 2023
> +Contact:	Alexander Graf <graf@amazon.com>
> +Description:
> +		When the kernel was booted with an initrd and the
> +		"retain_initrd" option is set on the kernel command
> +		line, /sys/firmware/initrd contains the contents of the
> +		initrd that the kernel was booted with.
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 65731b060e3f..51575cd31741 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2438,7 +2438,7 @@
>  			between unregistering the boot console and initializing
>  			the real console.
> =20
> -	keepinitrd	[HW,ARM]
> +	keepinitrd	[HW,ARM] See retain_initrd.
> =20
>  	kernelcore=3D	[KNL,X86,IA-64,PPC]
>  			Format: nn[KMGTPE] | nn% | "mirror"
> @@ -5580,7 +5580,8 @@
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
> =20
> -	retain_initrd	[RAM] Keep initrd memory after extraction
> +	retain_initrd	[RAM] Keep initrd memory after extraction. After boot, it=
 will
> +			be accessible via /sys/firmware/initrd.
> =20
>  	retbleed=3D	[X86] Control mitigation of RETBleed (Arbitrary
>  			Speculative Code Execution with Return Instructions)
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 8d0fd946cdd2..25244e2a5739 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -574,6 +574,16 @@ extern unsigned long __initramfs_size;
>  #include <linux/initrd.h>
>  #include <linux/kexec.h>
> =20
> +static ssize_t raw_read(struct file *file, struct kobject *kobj,
> +			struct bin_attribute *attr, char *buf,
> +			loff_t pos, size_t count)
> +{
> +	memcpy(buf, attr->private + pos, count);
> +	return count;
> +}
> +
> +static BIN_ATTR(initrd, 0440, raw_read, NULL, 0);
> +
>  void __init reserve_initrd_mem(void)
>  {
>  	phys_addr_t start;
> @@ -715,8 +725,14 @@ static void __init do_populate_rootfs(void *unused, =
async_cookie_t cookie)
>  	 * If the initrd region is overlapped with crashkernel reserved region,
>  	 * free only memory that is not part of crashkernel region.
>  	 */
> -	if (!do_retain_initrd && initrd_start && !kexec_free_initrd())
> +	if (!do_retain_initrd && initrd_start && !kexec_free_initrd()) {
>  		free_initrd_mem(initrd_start, initrd_end);
> +	} else if (do_retain_initrd) {
> +		bin_attr_initrd.size =3D initrd_end - initrd_start;
> +		bin_attr_initrd.private =3D (void *)initrd_start;
> +		if (sysfs_create_bin_file(firmware_kobj, &bin_attr_initrd))
> +			pr_err("Failed to create initrd sysfs file");
> +	}
>  	initrd_start =3D 0;
>  	initrd_end =3D 0;
> =20

On my Arch Linux system, /sys/firmware/initrd is not same as initramfs image
=66rom /boot partition that is uncompressed. `ls -l` listing shows
(with /tmp/initramfs-boot is unzstd'ed initramfs of the same kernel booted):

```
-r--r----- 1 root root 22967535 Dec  7 19:32 /sys/firmware/initrd
-rw------- 1 root root 40960000 Dec  7 19:26 /tmp/initramfs-boot
```

And thus, `cpio -i -v` listing differs. While in uncompressed initramfs,
I got expected initramfs contents (early userpace for booting), doing the s=
ame
to /sys/firmware/initrd only shows Intel microcode.

Regardless, exposing initramfs as advertised in the patch description works=
 for
me.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--yzFdKNTogRVNR2zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXG8mAAKCRD2uYlJVVFO
o/ixAQC2Uj6riROn4UtbBECKf3ytEaYmrSre3KY8Xv5dBKfbIwEAxVJhlOfAk5Tm
K/0PfSLkbjvAQPawba1/pN0cnw67HQ0=
=Yz+K
-----END PGP SIGNATURE-----

--yzFdKNTogRVNR2zX--
