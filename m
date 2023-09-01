Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87B78FC13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349094AbjIALH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjIALH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:07:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6FE42;
        Fri,  1 Sep 2023 04:07:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CAECD2185F;
        Fri,  1 Sep 2023 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693566441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8a57AjKskzWCykzi4HsClcp/cOx+3HL/9e63h2uPTF4=;
        b=IcxVSLHhJ6IEwkLwitDotQ00lwS6BOSQWmQAAlN5CwhS3rzd+E8j4iFjMTw4lt4LldyVyC
        rhXd0yYekF317gTrF6Sei8v8ZtW5QyJfpOfr6llJb/bfWnxQgQ/RTe+sAuG+IpJNI2xTY2
        PKaFzJNZoxgRCMRyU3JGWI/hFrcFFkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693566441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8a57AjKskzWCykzi4HsClcp/cOx+3HL/9e63h2uPTF4=;
        b=H2/AX4Bd9itzYhoL7+z7uqLchSRAQX7Y9Iozu/HLAZej1BQol9UAnz1JH56WkADWtYUJUe
        EgMc93+f69FYaeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95F7513582;
        Fri,  1 Sep 2023 11:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0f+AIunF8WTwdQAAMHmgww
        (envelope-from <dkirjanov@suse.de>); Fri, 01 Sep 2023 11:07:21 +0000
Message-ID: <a67042bc-ec43-17a4-257e-8276646fc0e3@suse.de>
Date:   Fri, 1 Sep 2023 14:07:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_net/socket=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSB1c2Vk?=
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230902182228.3124-1-zeming@nfschina.com>
From:   Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20230902182228.3124-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/23 21:22, Li zeming wrote:
> used is assigned first, so it does not need to initialize the
> assignment.

that should be posted to net-next once it open

> 
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  net/socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 2b0e54b2405c..743e54eba06f 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -569,12 +569,12 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
>  				size_t size)
>  {
>  	ssize_t len;
> -	ssize_t used = 0;
> +	ssize_t used;
>  
>  	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
>  	if (len < 0)
>  		return len;
> -	used += len;
> +	used = len;
>  	if (buffer) {
>  		if (size < used)
>  			return -ERANGE;
