Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9B80C8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjLKL6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjLKL6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:58:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3CCF;
        Mon, 11 Dec 2023 03:58:40 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0198821F9A;
        Mon, 11 Dec 2023 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702295918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYP60kuBsPr13bP02sYeJ5TU5tiuN45DqYhnJDEhy3A=;
        b=iIpoJJc2Wa7cd2mITwjandznBhAaHdw9DKxeeOLjNyJKNutNLIfdE2OHqpoKwhTI2UenA8
        wMxd4wQh9cUNsAzBLOWpFWZxePIpkrwxwA4Re/o9cPLY/UP6whk9s6kh0yLjTKE7Hza07F
        vvEfvZbq1Iq4v9Myy1NXeM3jSho1y44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702295918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYP60kuBsPr13bP02sYeJ5TU5tiuN45DqYhnJDEhy3A=;
        b=YyDLWJJLm1wV+jB/Wrfg56KheTOV5Y5msMR4Ev07RIspesaSR8SbPvgKdRerqzUl4Cauow
        5JYiLX5aIRjggqDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702295918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYP60kuBsPr13bP02sYeJ5TU5tiuN45DqYhnJDEhy3A=;
        b=iIpoJJc2Wa7cd2mITwjandznBhAaHdw9DKxeeOLjNyJKNutNLIfdE2OHqpoKwhTI2UenA8
        wMxd4wQh9cUNsAzBLOWpFWZxePIpkrwxwA4Re/o9cPLY/UP6whk9s6kh0yLjTKE7Hza07F
        vvEfvZbq1Iq4v9Myy1NXeM3jSho1y44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702295918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYP60kuBsPr13bP02sYeJ5TU5tiuN45DqYhnJDEhy3A=;
        b=YyDLWJJLm1wV+jB/Wrfg56KheTOV5Y5msMR4Ev07RIspesaSR8SbPvgKdRerqzUl4Cauow
        5JYiLX5aIRjggqDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE260138FF;
        Mon, 11 Dec 2023 11:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 9B1kLm35dmXZPAAAn2gu4w
        (envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 11:58:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CE7B7A07E3; Mon, 11 Dec 2023 12:58:36 +0100 (CET)
Date:   Mon, 11 Dec 2023 12:58:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, Jan Kara <jack@suse.cz>,
        Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        chrubis@suse.cz, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>
Subject: Re: ext4 data corruption in 6.1 stable tree (was Re: [PATCH 5.15
 000/297] 5.15.140-rc1 review)
Message-ID: <20231211115836.pz2aicqcdva5l3og@quack3>
References: <20231124172000.087816911@linuxfoundation.org>
 <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
 <20231127155557.xv5ljrdxcfcigjfa@quack3>
 <CAEUSe7_PUdRgJpY36jZxy84CbNX5TTnynqU8derf0ZBSDtUOqw@mail.gmail.com>
 <20231205122122.dfhhoaswsfscuhc3@quack3>
 <4118ca20-fb7d-4e49-b08c-68fee0522d3d@roeck-us.net>
 <2023120643-evade-legal-ee74@gregkh>
 <ZXbIONRdDQx+mDwI@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXbIONRdDQx+mDwI@duo.ucw.cz>
X-Spam-Score: 10.13
X-Spamd-Result: default: False [3.29 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         R_RATELIMIT(0.00)[to_ip_from(RLygd54ukgnzz988sh5z56xufj)];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_TRACE(0.00)[suse.cz:+];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         RCPT_COUNT_TWELVE(0.00)[22];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[linuxfoundation.org,roeck-us.net,suse.cz,linaro.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,kernel.org,kernelci.org,lists.linaro.org,nvidia.com,gmail.com,sladewatkins.net,gmx.de,mit.edu];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spamd-Bar: +++
X-Rspamd-Server: rspamd1
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0198821F9A
X-Spam-Score: 3.29
Authentication-Results: smtp-out1.suse.de;
        dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iIpoJJc2;
        dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YyDLWJJL;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
        dmarc=none
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-12-23 09:28:40, Pavel Machek wrote:
> > > > So I've got back to this and the failure is a subtle interaction between
> > > > iomap code and ext4 code. In particular that fact that commit 936e114a245b6
> > > > ("iomap: update ki_pos a little later in iomap_dio_complete") is not in
> > > > stable causes that file position is not updated after direct IO write and
> > > > thus we direct IO writes are ending in wrong locations effectively
> > > > corrupting data. The subtle detail is that before this commit if ->end_io
> > > > handler returns non-zero value (which the new ext4 ->end_io handler does),
> > > > file pos doesn't get updated, after this commit it doesn't get updated only
> > > > if the return value is < 0.
> > > > 
> > > > The commit got merged in 6.5-rc1 so all stable kernels that have
> > > > 91562895f803 ("ext4: properly sync file size update after O_SYNC direct
> > > > IO") before 6.5 are corrupting data - I've noticed at least 6.1 is still
> > > > carrying the problematic commit. Greg, please take out the commit from all
> > > > stable kernels before 6.5 as soon as possible, we'll figure out proper
> > > > backport once user data are not being corrupted anymore. Thanks!
> > > > 
> > > 
> > > Thanks a lot for the update.
> > > 
> > > Turns out this is causing a regression in chromeos-6.1, and reverting the
> > > offending patch fixes the problem. I suspect anyone running v6.1.64+ may
> > > have a problem.
> > 
> > Jan, thanks for the report, and Guenter, thanks for letting me know as
> > well.  I'll go queue up the fix now and push out new -rc releases.
> 
> Would someone have a brief summary here? I see 6.1.66 is out but I
> don't see any "Fixes: 91562895f803" tags.
> 
> Plus, what is the severity of this? It is "data being corrupted when
> using O_SYNC|O_DIRECT" or does metadata somehow get corrupted, too?

It is pure data corruption happening for ext4 direct IO writes because they
do not properly update current file position after the write.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
