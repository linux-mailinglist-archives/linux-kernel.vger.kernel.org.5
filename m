Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591467667E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjG1Ix5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjG1IxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:53:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26203A94;
        Fri, 28 Jul 2023 01:52:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 998D51F8A4;
        Fri, 28 Jul 2023 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690534343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKtnymo9BLKjAzCCZVciNLZvMc0xORujL4hCyHzOE4c=;
        b=gXv6eHrvR/UWfZtWKuPI8GUxOYdPbsRflxT+0gHNH3rzlODSYFZSAZYlL4phngo5lr0iLW
        +Gw0rh/oclnk9UvR5I1yG4uAmzn7xyt1E/sZumrGU6hW1RVZCk7PWyYiKf60nvagZAwk1i
        6De5KlmovVCkdSS44cMosq2RFacZmHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690534343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKtnymo9BLKjAzCCZVciNLZvMc0xORujL4hCyHzOE4c=;
        b=JzlQ9CwhlQ0T1P9qLKLupGJ0J3d2l4fnF0oKTrdTsFGTJtyGLnAkLA/LmhI6G/RKun5pUi
        eX2r2ot3yc9iWcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89B1B133F7;
        Fri, 28 Jul 2023 08:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KdT3IMeBw2TMdQAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 08:52:23 +0000
Date:   Fri, 28 Jul 2023 10:52:23 +0200
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
Subject: Re: [PATCH blktests v1 05/11] nvme/{041,042,043,044,045,048}: Remove
 local variable hostnqn and hostid
Message-ID: <rqcyq6qhhiulveoi5t3sp3tkcwlyhwmh4qpvplskssfd6d2cr5@u53vr5xlizyo>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-6-dwagner@suse.de>
 <keqqev3paa2rtk5ysaitglnqfokeph7uvqh4z377atjlow65eh@buvr5azvul4s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <keqqev3paa2rtk5ysaitglnqfokeph7uvqh4z377atjlow65eh@buvr5azvul4s>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:10:09AM +0000, Shinichiro Kawasaki wrote:
> On Jul 26, 2023 / 14:46, Daniel Wagner wrote:
> > Commit acc408477e85 ("nvme/{041,042,043,044,045,048}: Use default
> > hostnqn and hostid") switched the test over to use the default
> > hostnqn. It missed the change to remove the local variable and
> > use the def_hostnqn/def_hostid directly.
> 
> [...]
> 
> > diff --git a/tests/nvme/043 b/tests/nvme/043
> > index 6392bd8b2492..5569a7a58ad5 100755
> > --- a/tests/nvme/043
> > +++ b/tests/nvme/043
> > @@ -26,17 +26,13 @@ test() {
> >  	_setup_nvmet
> >  
> >  	local port
> > -	local hostid
> > -	local hostnqn
> >  	local file_path="${TMPDIR}/img"
> >  	local hash
> >  	local dhgroup
> >  	local hostkey
> >  	local ctrldev
> >  
> > -	hostid="${def_hostid}"
> > -	hostnqn="${def_hostnqn}"
> > -	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
> > +	hostkey="$(nvme gen-dhchap-key -n ${def_hostnqn} 2> /dev/null)"
> 
> As I commented on the previous patch, the left reference to subsys_name is
> replaced def_hostnqn. It means that the -n option value changes. I guess
> this change is fine for this test. Could you confirm it?

This change should be in the previous patch as you commented in the previous
patch. This is an artifact from my devel steps.
