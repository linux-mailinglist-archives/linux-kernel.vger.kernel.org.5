Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCE7667EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjG1I4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjG1I4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:56:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689BA0;
        Fri, 28 Jul 2023 01:55:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 801261F854;
        Fri, 28 Jul 2023 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690534528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uAWKzqRAwM9WVlQh+HXjiVoc+9cES0KQ8DeLucaBVgg=;
        b=fnJ3zXeJfj3bLH3le16xDYUsOQ79o2TzjmECfwDbGR2i2gJ4lN7aph8XqyEcpjSdlwl6wA
        ZgTlxrRLGTOC8EYB7PAyL+QVHQqITh1pY0x+qOoonIVXl6AM56K0ia3s1BVk2oaEQPbrpv
        1lliJKDjRh1ysVQ97gwSoLU90kdjILk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690534528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uAWKzqRAwM9WVlQh+HXjiVoc+9cES0KQ8DeLucaBVgg=;
        b=D6SUtbiY3lYQSIKNFOL90txpnKb4VrD41xFd1UFe3P8ZGgA6s0uJYHFicmtlOX54XL0sNz
        pgPJd5qjEBkevsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F4DD133F7;
        Fri, 28 Jul 2023 08:55:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fw0hG4CCw2RidwAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 08:55:28 +0000
Date:   Fri, 28 Jul 2023 10:55:27 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 11/11] nvme: Add explicitly host to
 allow_host list
Message-ID: <tgchxlramrmairlqojfw5tim2hqgvwu3iug532lyu2lzrjk4pw@geegddpo3zqw>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-12-dwagner@suse.de>
 <4eztk7hhup2le6nqd4u4udvdrek3sngrljfr22b7rnhaqcr4of@aoe2j52jfwzb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eztk7hhup2le6nqd4u4udvdrek3sngrljfr22b7rnhaqcr4of@aoe2j52jfwzb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:15:45AM +0000, Shinichiro Kawasaki wrote:
> On Jul 26, 2023 / 14:46, Daniel Wagner wrote:
> > Only allow to connect to our setup target with the correct hostnqn.
> > 
> > Thus we have to explicitly add the test hostnqn to the test subsysnqn
> > allow_host list.
> 
> [...]
> 
> > --- a/tests/nvme/030
> > +++ b/tests/nvme/030
> > @@ -28,6 +28,7 @@ test() {
> >  
> >  	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
> >  	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
> > +	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
> >  
> >  	genctr=$(_discovery_genctr)
> >  
> > @@ -36,13 +37,13 @@ test() {
> >  
> >  	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
> >  
> > -	echo 0 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> > +	_add_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
> >  
> > -	genctr=$(_check_genctr "${genctr}" "clearing attr_allow_any_host")
> > +	genctr=$(_check_genctr "${genctr}" "adding host to allow_hosts")
> >  
> > -	echo 1 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> > +	_remove_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
> >  
> > -	genctr=$(_check_genctr "${genctr}" "setting attr_allow_any_host")
> > +	genctr=$(_check_genctr "${genctr}" "removing host from allow_hosts")
> >  
> >  	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
> >  	_remove_nvmet_subsystem "${subsys}2"
> 
> The hunk above looks different from other changes. Is it changing test
> content slightly to meet request by Max? If so, it would be good to note
> in the commit message.

I should have explained this change in the commit message. When we use
allowed_hosts, the attr_allow_any_host feature is disabled and thus has no side
effects like updating the genctr. This makes the test fail. I opted to use
_[add|remove]_nvmet_allow_hosts to trigger the same side effect. While at it, I
also updated the logging info.
