Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE3774BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjHHUxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjHHUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:53:36 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD9421797;
        Tue,  8 Aug 2023 13:39:30 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DF2BB3F7B7;
        Tue,  8 Aug 2023 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691527169;
        bh=rwhgNCgCm4EhMb9h8pB1jFw10fTpnGr8gIdPRM1+pEY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PqIUVK41G9gdA+HLd9j1+rmGhkiPrUIPA5JI0T4bTxKpjkVths1rYgL2vCGnSBGIS
         YQIp6TNMjys9A7yJCjF0QvNB8kmDP2R7d09HRCNqEi/p+2DPre2PZfGLU03tq+IWXg
         1ML2AJX8NUT7crONFxMGxua+Su5EoELYLx6ae0zvRVTaaRio0bWD9936UJE18pUJ6L
         AF2/1JvIiDZQwhnt+ZuX7gWsgd9nGmZsZb8iHGQWNdK7jg+MO3IPqmlkETn/axtAl5
         pw7hAQsLIXZK36iAlWGEKrZzQl0h0UzD3XaG3h9JvlZknxvqmE/b4aq3GYxxN57rCa
         sgEwMonqbTeAA==
Message-ID: <2c3a9d22-4e7b-ccf9-d43e-8e785401945f@canonical.com>
Date:   Tue, 8 Aug 2023 13:39:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] apparmor: cleanup unused declarations in policy.h
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, mike.salvatore@canonical.com
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230725141239.233372-1-xiujianfeng@huawei.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230725141239.233372-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 07:12, Xiu Jianfeng wrote:
> The implementions of these declarations do not exist, remove them all.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: John Johansen <john.johansen@canonical.com>

this has been pulled into apparmor-next


> ---
>   security/apparmor/include/policy.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
> index 545f791cabda..6e5ec9c37b48 100644
> --- a/security/apparmor/include/policy.h
> +++ b/security/apparmor/include/policy.h
> @@ -227,10 +227,6 @@ extern enum profile_mode aa_g_profile_mode;
>   #define profiles_ns(P) ((P)->ns)
>   #define name_is_shared(A, B) ((A)->hname && (A)->hname == (B)->hname)
>   
> -void aa_add_profile(struct aa_policy *common, struct aa_profile *profile);
> -
> -
> -void aa_free_proxy_kref(struct kref *kref);
>   struct aa_ruleset *aa_alloc_ruleset(gfp_t gfp);
>   struct aa_profile *aa_alloc_profile(const char *name, struct aa_proxy *proxy,
>   				    gfp_t gfp);
> @@ -239,14 +235,12 @@ struct aa_profile *aa_alloc_null(struct aa_profile *parent, const char *name,
>   struct aa_profile *aa_new_learning_profile(struct aa_profile *parent, bool hat,
>   					   const char *base, gfp_t gfp);
>   void aa_free_profile(struct aa_profile *profile);
> -void aa_free_profile_kref(struct kref *kref);
>   struct aa_profile *aa_find_child(struct aa_profile *parent, const char *name);
>   struct aa_profile *aa_lookupn_profile(struct aa_ns *ns, const char *hname,
>   				      size_t n);
>   struct aa_profile *aa_lookup_profile(struct aa_ns *ns, const char *name);
>   struct aa_profile *aa_fqlookupn_profile(struct aa_label *base,
>   					const char *fqname, size_t n);
> -struct aa_profile *aa_match_profile(struct aa_ns *ns, const char *name);
>   
>   ssize_t aa_replace_profiles(struct aa_ns *view, struct aa_label *label,
>   			    u32 mask, struct aa_loaddata *udata);

