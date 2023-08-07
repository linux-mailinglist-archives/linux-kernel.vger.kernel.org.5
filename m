Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72777303E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjHGUVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHGUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:21:43 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA9D10DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691439702; bh=Lou0w8eP6l1wtzRbBZ0WGxXLaNjvLVdtESPIEH7pE4g=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=hgTSIcCJWdtpEUaE64RStf3vjSHT/rhExxqJarHrTcS3QHp519xQpY5UOhnysLUfN3h36rKB17uuUnckTKf1Vnh2mjUoqL8IqZcgbgcMBzV3Uc4HAtvMoBM93nMjrMtp/FatFd/C6FSyCi9m4FIsCjyjbI/PK6xpmzc/X6WIruu7zQmQfkjDkntpXhnfJjAUAmcvCZ5yG2JPceg/cikdzjDeqgtbxfK8v4ggKbp0jfkTLOTdjThkdzw6OwNt+EbDxBPOt3gmkv5utiWcUEBdarRX4H32x5Z9eFQ2wgGHpJfFgZNeMJGwKEoHU2YSkwLAxxkh5tRX6srRrUKEwOBPag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691439702; bh=Vx0pywHIYNtObHCs4Y/cpffw+b7ey4IcqD+gEL3PiN9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ChEGcYMbPEomlCsILwk9ZrzIaJqvu2ZysJOMsL22TpUJqde37wDjw76TOz+R++4CK4ZLuCnhAAEUgN+sR0FFcZNdzt53xnUfx8kNxxOV8cjd1njb4ne1NegJHlJxHt80I1En60pIyCZDeJ5QLIB/0YEb62bpYq1VapP5/PhMV3y6ofMIA0VyurnQ+224vAnh9ircPmkqB9Au77TI8YK/Zo8tizNwsj66Bx0Rken2474S7l7xXxJu2L8P2H+NMnsF5WyCbX6cb8CoJU01oGZJCkfEaPz5fonNJX7eM54+ibv/p+NVzg2IzJ95zjX2qJUVY2SzN7Cw1n66t6v9UMSepA==
X-YMail-OSG: _6xvdf0VM1klGjjNNloYourC8sQHyx5trY7439cfHVnXl5Q8NAfkaXDgMAz0_S.
 y9fXfJMYPXKJJ8aI1OcuEGqzaXXvnzSV.LlT4vvR..MXJ9848H3HT11iKgRhQikE0KshxUcYuWW5
 e3ndrjln1516PLjW0hBfi7uSlYlmgrdz4xJVxeOZm69ElVgvtS2jkVUZUwTlFZmM4_n9MfMZ8B1L
 QltFRVwhSmSXo0awL0SPYR8rsKyeQkOi7q2YHLmMRMCpduC3QX7ZjaX9d8SpxBauGpEDYnvB26Qw
 pR08drAy_XFZV.5La4v7uwdmoNnwSAzigskdPZDFanRM5m6SlrQ6_ZvnBk7kw.W4uV5G8InSQv.k
 yVdGk0hzrMiBfaa7NaFM9qE0T.JnK9mt3YdhdVpfHpdftWlyco4OFpi7gB9gT9FAs_8aryJviZIG
 2BaVcS2IYu812wf0GoZ7DnCwYss7hgq18I4DQyD.CimgPX_XSGC_7bb_HB3VAiEvrpu2jXzhbmEL
 xHQwyb9kHlLjN2lRm6W92st8yY4T9DV4QyfX9Bdaeo_Ra6J_kHElOob5c.cJofm9_VrjtGpDj.aS
 7rhQQC3a.OlyDXRxMeQsfxyybXIu0zs9jgqbeUsfa5VBWl2C70tOu4nA1Fg8nRF_8WJ.LRKAcJQR
 y1XHytM5yC5b_zyCmd.vjcD32W3bZ1gGw7ogCW4I6u6oF_LDr8y7a8ZLI9.R2GVaU9xTds6zaGtJ
 .UjaXfqr_bJZ_Obubpdk_.fju5ngXuW1a2etFQpPTq0mNckSiZLF7S7UYL5.CVg5_Dh0Ua5Re2L6
 p96MoUTS3onZ6hoz5GGZMOsIVsDPIEeLRsy5QnYH.mxo_AjYDuul73Lo6YRXV68Y_MdhTsNEaqbo
 YMsVPxdQZstYfrAwHZqaxqW2Uw4yAT1sxejPcJiZwIgUTswjh62DjdUtqWckt9OmpFIbLmtxPueX
 ZYctg_4gRHevza8b5_xQtrva_LLk4j0Ck4amUAFNfVEHHtKyIwoE4WBil40nlwjX3qXEZFMQEUH7
 tWdEmkGxdm21kwbSOt1W_VPaly40zs6yU3TSTDaZS5MB65rIN1zokGK_iPMqiWg2RkqcW9bTTspY
 ZWpOactmxRTfDJ0jc3HLx1txB.iLvoyIg484Bd4mM4frEOx34s1iXnMlWsuUzfG6YIWU2iJvtmHn
 gn8zvfJ_XC2UZl2dfqC14lkIkMtX5BTl4.lwHZ1381JvCuQ3z8F..vqLxbrEW8h85FWCg3Y5wNML
 YHVVSLdlc20ehPjF3a1GfwNV3stA9mBLw.bgwdbhl7aOOhoq85y5BoNaRLSz1y5d4eVmVR7lo8xh
 RuwNNILQW3B8VNq.R8zV3JlrAe7WUAyHyIOII7yRdVt99BPekFvje2aonn00eJQkVkSDSvru_BsA
 1bkLoU2XYO5fHZfCS_qnUlakB4kAMU3k6UbUTk0UHjffqu2SlAkkTQAtjUhKcdubOUJ9UjfSzbQ7
 IpyDjpMiWkXH7hvje5pJh_SSY5ZZc6r_rJPiPXGGxut0SDQWLcoURl8VBq.rUJA7dhlEfCZjTd3N
 9x2zImYo.ffhHtWPGXR03GGFkSHWjNFqaYa61bnlfNVsN57FexKBjFy.siUVF1Y24YLFZ4KtDK3r
 r8KjeopejW1ysi5627FWjrLHBZUwapeKyQkSvQ.B2MefaVJVg2bkjWpF5jBxr72fSsJmfwNIW.8c
 w50xUwVWFFVCWO.N.Po145JDyzePJeoitAn2.jZo8t2JoK30ihb8yJNI2kKciiV_jV_zNOlGx4ka
 L4Vjzzq23..kR0hbP3RFh.6s5Vt_SC13hROTJW8lu46voqJSw8Hl1WUA37jWo977Nbvr.Nge2uMq
 .Un0CBxNhPi4rM0jpllmC083p_9_NCscHyLRmQrHnw9M1ZmhkoPpgRIQ11RX1YtoMvgGolvM7Lck
 ANJ1sqS120nD7VqwTfmROumhw0YaSrSJKoOoRvuchvJr6p5kugeIkhfXXe6rCSHUDYb.nH8ctZTz
 ASW6SYqK7sQkt0B2ngw5eDWMagiJ2IqRzpTYyisv2eaJNhOHj8nGm6rpKZq3iqAzwJXKCtVPfdyO
 HkTibaJofmJ02yn58yus9UgGXV5bPpJUt_i1y_pGd3cz9CLJT0aKDE0SJeCSQEMLdYoz8sw0DGot
 1c29p7lvrGT8QW7l5lqaLSP6C9W5bGSxcjmy3iVBGJOUJvr3tyOyE0.hu2HYpvjdnwZ7ec1ekwjQ
 mayDhXgCTEqwcZ_mwwFLueaQkkRF3dPKMxHnRcAmlNBVNZVGyuk3EaaX1TE75bdVppp.a7734vg-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 776e9034-b1d9-4fb8-adf6-ee127e71ad75
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 7 Aug 2023 20:21:42 +0000
Received: by hermes--production-gq1-6b7c87dcf5-qfzfj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 833ccea0cee42ecbc52cb146008ea604;
          Mon, 07 Aug 2023 20:21:38 +0000 (UTC)
Message-ID: <c5b07b78-f37e-6e95-9c2e-044afe1dd894@schaufler-ca.com>
Date:   Mon, 7 Aug 2023 13:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 03/13] Implement CAP_TRUST capability.
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230710102319.19716-1-greg@enjellic.com>
 <20230710102319.19716-4-greg@enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230710102319.19716-4-greg@enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2023 3:23 AM, Dr. Greg wrote:
> TSEM was designed to support a Trust Orchestration System (TOS)
> security architecture.  A TOS based system uses the concept of a
> minimum Trusted Computing Base of utilities, referred to as trust
> orchestrators, that maintain workloads in a trusted execution
> state.  The trust orchestrators are thus, from a security
> perspective, the most security privileged processes running on
> the platform.
>
> The CAP_ML (machine modeling) capability is defined as a
> capability that allows a process to alter the modeling and hence
> the trust status of the platform.  In a fully orchestrated system
> only the trust orchestrator carry this capability bit and then
> drop the capability for the execution of the workload.  This is
> designed to prevent a security vulnerability in workloads to be
> leveraged to create an entity that could conduct adversarial
> modifications to the trust status of the platform.
>
> With the introduction of TSEM there are three generic mechanisms
> for implementing security contols, each with its own capability
> bit for management, ie:
>
> DAC - CAP_DAC_ADMIN

There is no CAP_DAC_ADMIN. There are several capabilities related
to changing the DAC state of the system.

>
> MAC - CAP_MAC_ADMIN

Since your system implements a mandatory access control policy
you should be using CAP_MAC_ADMIN.

>
> Security modeling - CAP_ML

First, the name you've chosen makes no sense at all. It isn't descriptive
and fails even as an abbreviation. Second, you aren't doing anything that
wouldn't be covered under CAP_MAC_ADMIN.

>
> Having a separate capability bit for security modeling allows DAC
> and classic label or path based MAC systems to be implemented in
> the context of a security modeling namespace.  Looking forward it
> is not unreasonable to consider the implementation of a modeling
> policy that would verify the status of extended attributes being
> used for label based MAC controls.

It seems reasonable that being trusted with the privilege to change
the modeling policy would imply sufficient trust to change other
security states where allowed. As the Smack maintainer, and having
introduced CAP_MAC_ADMIN, I say that there's insufficient grounds to
introduce a new, single purpose capability.

>
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  include/uapi/linux/capability.h     | 6 +++++-
>  security/selinux/include/classmap.h | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 3d61a0ae055d..4a17c9774505 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -417,7 +417,11 @@ struct vfs_ns_cap_data {
>  
>  #define CAP_CHECKPOINT_RESTORE	40
>  
> -#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
> +/* Allow modifications to the trust status of the system */
> +
> +#define CAP_ML	41
> +
> +#define CAP_LAST_CAP         CAP_ML
>  
>  #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>  
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..f367c269bbdb 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -30,7 +30,7 @@
>  		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
>  		"checkpoint_restore"
>  
> -#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
> +#if CAP_LAST_CAP > CAP_ML
>  #error New capability defined, please update COMMON_CAP2_PERMS.
>  #endif
>  
