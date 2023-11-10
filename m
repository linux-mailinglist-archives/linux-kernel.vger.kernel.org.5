Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7B7E827B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjKJTV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjKJTVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:21:25 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1531E5F;
        Fri, 10 Nov 2023 03:52:23 -0800 (PST)
Received: from [10.30.9.95] (unknown [195.13.248.78])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E5431401DD;
        Fri, 10 Nov 2023 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699617141;
        bh=272zjwdWnAlT1OR38ZdU7azH6pr5RExUaNQfqUz83Vs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=lT1GjfV1UovksAQ5doa3wNWJ+PmuHF8Y/ScljcKMdTW7v9vdOZXJMu4cId9Dpenvo
         BSU/atzFBSbtTjhSkrkeFXmLBGVuV/KFgOCMBWucIFHJlAs36ZqgXdtWxyWJHbqfP9
         rLT+OXsA+6UIXlT9QOqBJK6gK1C/3W0K6rliicG9bEedoMYrtlFwduKHN5FlbB5Leg
         XteUt3+JzmTs499WOFvSN9DjGZMikctwttvewUtZ+un8Cd1wx38xJDLDjuyM60Pbhv
         3SS/CmiM6/xrlhNZoYRFC+9BC+h63plE04FK+mv1plLMsqmG2wP8FfcNdVhR0dLoQA
         w1mGRJ3C/XHMA==
Message-ID: <9a2daab5-c9c8-4f62-8012-b851631d2b26@canonical.com>
Date:   Fri, 10 Nov 2023 03:52:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: switch SECURITY_APPARMOR_HASH from sha1 to
 sha256
Content-Language: en-US
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-crypto@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231022194026.313584-1-dimitri.ledkov@canonical.com>
From:   John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20231022194026.313584-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/23 12:40, Dimitri John Ledkov wrote:
> sha1 is insecure and has colisions, thus it is not useful for even
> lightweight policy hash checks. Switch to sha256, which on modern
> hardware is fast enough.
> 
> Separately as per NIST Policy on Hash Functions, sha1 usage must be
> withdrawn by 2030. This config option currently is one of many that
> holds up sha1 usage.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I am pulling this into apparmor-next-queue and plan to drop this into
apparmor-next as soon as 6.7-r1 is released.

> ---
>   security/apparmor/Kconfig      | 12 ++++++------
>   security/apparmor/apparmorfs.c | 16 ++++++++--------
>   security/apparmor/crypto.c     |  6 +++---
>   3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index e0d1dd0a19..64cc3044a4 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -57,10 +57,10 @@ config SECURITY_APPARMOR_INTROSPECT_POLICY
>   	  cpu is paramount.
>   
>   config SECURITY_APPARMOR_HASH
> -	bool "Enable introspection of sha1 hashes for loaded profiles"
> +	bool "Enable introspection of sha256 hashes for loaded profiles"
>   	depends on SECURITY_APPARMOR_INTROSPECT_POLICY
>   	select CRYPTO
> -	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
>   	default y
>   	help
>   	  This option selects whether introspection of loaded policy
> @@ -74,10 +74,10 @@ config SECURITY_APPARMOR_HASH_DEFAULT
>          depends on SECURITY_APPARMOR_HASH
>          default y
>          help
> -         This option selects whether sha1 hashing of loaded policy
> -	 is enabled by default. The generation of sha1 hashes for
> -	 loaded policy provide system administrators a quick way
> -	 to verify that policy in the kernel matches what is expected,
> +	 This option selects whether sha256 hashing of loaded policy
> +	 is enabled by default. The generation of sha256 hashes for
> +	 loaded policy provide system administrators a quick way to
> +	 verify that policy in the kernel matches what is expected,
>   	 however it can slow down policy load on some devices. In
>   	 these cases policy hashing can be disabled by default and
>   	 enabled only if needed.
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index a608a6bd76..082581397d 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1474,7 +1474,7 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
>   	rawdata->dents[AAFS_LOADDATA_REVISION] = dent;
>   
>   	if (aa_g_hash_policy) {
> -		dent = aafs_create_file("sha1", S_IFREG | 0444, dir,
> +		dent = aafs_create_file("sha256", S_IFREG | 0444, dir,
>   					      rawdata, &seq_rawdata_hash_fops);
>   		if (IS_ERR(dent))
>   			goto fail;
> @@ -1644,11 +1644,11 @@ static const char *rawdata_get_link_base(struct dentry *dentry,
>   	return target;
>   }
>   
> -static const char *rawdata_get_link_sha1(struct dentry *dentry,
> +static const char *rawdata_get_link_sha256(struct dentry *dentry,
>   					 struct inode *inode,
>   					 struct delayed_call *done)
>   {
> -	return rawdata_get_link_base(dentry, inode, done, "sha1");
> +	return rawdata_get_link_base(dentry, inode, done, "sha256");
>   }
>   
>   static const char *rawdata_get_link_abi(struct dentry *dentry,
> @@ -1665,8 +1665,8 @@ static const char *rawdata_get_link_data(struct dentry *dentry,
>   	return rawdata_get_link_base(dentry, inode, done, "raw_data");
>   }
>   
> -static const struct inode_operations rawdata_link_sha1_iops = {
> -	.get_link	= rawdata_get_link_sha1,
> +static const struct inode_operations rawdata_link_sha256_iops = {
> +	.get_link	= rawdata_get_link_sha256,
>   };
>   
>   static const struct inode_operations rawdata_link_abi_iops = {
> @@ -1739,7 +1739,7 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
>   	profile->dents[AAFS_PROF_ATTACH] = dent;
>   
>   	if (profile->hash) {
> -		dent = create_profile_file(dir, "sha1", profile,
> +		dent = create_profile_file(dir, "sha256", profile,
>   					   &seq_profile_hash_fops);
>   		if (IS_ERR(dent))
>   			goto fail;
> @@ -1749,9 +1749,9 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
>   #ifdef CONFIG_SECURITY_APPARMOR_EXPORT_BINARY
>   	if (profile->rawdata) {
>   		if (aa_g_hash_policy) {
> -			dent = aafs_create("raw_sha1", S_IFLNK | 0444, dir,
> +			dent = aafs_create("raw_sha256", S_IFLNK | 0444, dir,
>   					   profile->label.proxy, NULL, NULL,
> -					   &rawdata_link_sha1_iops);
> +					   &rawdata_link_sha256_iops);
>   			if (IS_ERR(dent))
>   				goto fail;
>   			aa_get_proxy(profile->label.proxy);
> diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
> index 6724e2ff6d..aad486b2fc 100644
> --- a/security/apparmor/crypto.c
> +++ b/security/apparmor/crypto.c
> @@ -106,16 +106,16 @@ static int __init init_profile_hash(void)
>   	if (!apparmor_initialized)
>   		return 0;
>   
> -	tfm = crypto_alloc_shash("sha1", 0, 0);
> +	tfm = crypto_alloc_shash("sha256", 0, 0);
>   	if (IS_ERR(tfm)) {
>   		int error = PTR_ERR(tfm);
> -		AA_ERROR("failed to setup profile sha1 hashing: %d\n", error);
> +		AA_ERROR("failed to setup profile sha256 hashing: %d\n", error);
>   		return error;
>   	}
>   	apparmor_tfm = tfm;
>   	apparmor_hash_size = crypto_shash_digestsize(apparmor_tfm);
>   
> -	aa_info_message("AppArmor sha1 policy hashing enabled");
> +	aa_info_message("AppArmor sha256 policy hashing enabled");
>   
>   	return 0;
>   }

