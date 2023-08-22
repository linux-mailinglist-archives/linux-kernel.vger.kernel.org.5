Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACEC784A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHVT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHVT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:28:27 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7978DB;
        Tue, 22 Aug 2023 12:28:25 -0700 (PDT)
Received: from [10.8.192.2] (unknown [50.47.144.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9872C400FF;
        Tue, 22 Aug 2023 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692732504;
        bh=kvqkivsKxAV86aMsAMF0SdVAoMxhg68oNywBNC10nCg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=V3zuTMkMKuQATLOZBfUfkd9PpKwi9joQGoiCHXp9V8yEvI/d4XDDHT+4hTXdWRN11
         daN2taPyLKBKdIe/za00YrnEdqif3AxtjX6axGLQC+D+f7cbq8RD0uH2A28kxUerXA
         etNP+AjYdw5mJ8Zk8lu2845Jwp6hcRU+FVSpNt9fTwZagKwNBU/aoDZZyPykVz6XeA
         gJm7irWvNEOH00NzvbTXBJya1oQI3o4MU29orhVjfWQLMyjLAU0+eVHg9fMC5oGwyE
         2gVOT5Z73M8FXUs4qcoInJwZeh5kQuXZhp1h5IhlqSWVkykrX0DZzgPFoNrbZLhx3E
         +XYevpmTJc9rw==
Message-ID: <6d9e4dd9-4197-bbd1-eaf5-d79db0605ea3@canonical.com>
Date:   Tue, 22 Aug 2023 12:28:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] apparmor: remove unused PROF_* macros
Content-Language: en-US
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>
References: <20230807093904.565766-1-gongruiqi@huaweicloud.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230807093904.565766-1-gongruiqi@huaweicloud.com>
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

On 8/7/23 02:39, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> The last usage of PROF_{ADD,REPLACE} were removed by commit 18e99f191a8e
> ("apparmor: provide finer control over policy management"). So remove
> these two unused macros.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

sorry, I seem to have dropped my reply to this, I have
pulled this into apparmor-next

Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/include/policy.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/security/apparmor/include/policy.h b/security/apparmor/include/policy.h
> index 545f791cabda..ed9a8669af80 100644
> --- a/security/apparmor/include/policy.h
> +++ b/security/apparmor/include/policy.h
> @@ -254,9 +254,6 @@ ssize_t aa_remove_profiles(struct aa_ns *view, struct aa_label *label,
>   			   char *name, size_t size);
>   void __aa_profile_list_release(struct list_head *head);
>   
> -#define PROF_ADD 1
> -#define PROF_REPLACE 0
> -
>   #define profile_unconfined(X) ((X)->mode == APPARMOR_UNCONFINED)
>   
>   /**

