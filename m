Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7DA7C474C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344577AbjJKBbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbjJKBbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:31:34 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E712392
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:31:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DF2126C1EB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:26:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 443326C1CC1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:26:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696987577; a=rsa-sha256;
        cv=none;
        b=CN+tS2YUn1ZOr744enHWCZdhj7dV3npfYfeot7jRTfI6v3hEWu1y0nvsRLaA+8/uMwFIug
        GYkKGLWxKO6iCVjsTPH2n3b31kFBnKl4Cfz/mqucrR0MdNQ/cx1UOTQtVooKPZtiqjpNXf
        8EuoCVLlEWsr2saAfgDL3EwrZQ4aRxvUfNHXdhcazM4A92g0plnRRFnA3APTjyw2ab+25S
        pReK9JSb3Vy0ziSjWBZU70iHgrjvYPGG4tqg6gQaWoInwGlFZL1JvPlGnEe03igm7MpVp2
        pAJfGa3b2IA3IYuMl+TDhGwAFENpYDatR0F2A7VUzVgtpV2HnI3nvyECkHAuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696987577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=s+1MigLJtocBIGMEMIEnUREA5Z0e58g1st5qfLLh9Hs=;
        b=KYMQJs8HZkThwuTSS52gTEH9mZZuDJOL5XiogDEUPDzz8+3qXoHsFRIYDNmPHbKweqSwd5
        mEBkuLsuDlVjB1eAJsxp+WhBD537aYeoSnP33XidbL73AIjLVO0zyE0GomwCcIC/AzZ/oq
        MsB6U3DdLIXFB62wza8c09SoOdUvN1zHFZ12T+94S3RD3DBcM3yptpgoREfuhPnsqggReN
        YHJwYoiNkVw+HlwOCCg6QUWPV5K8KzX5ThdE7gZKoqTDDrmt0KDEEYxaP3M9fWkH342x7/
        B6DsmJH0Qu1pooxVy3AS9oIZ8hypJ3Ik0CwZ8/UuiZMI4eHmkJg3FAmmlxmx+g==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-hwtmw;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Hook-Celery: 5285a62b6dafaf41_1696987577506_4237265757
X-MC-Loop-Signature: 1696987577506:2915971830
X-MC-Ingress-Time: 1696987577505
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.92.149 (trex/6.9.1);
        Wed, 11 Oct 2023 01:26:17 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S4w8T00pSzB2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696987577;
        bh=s+1MigLJtocBIGMEMIEnUREA5Z0e58g1st5qfLLh9Hs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bI1i99laWwDBbkwQApyOuRy4WL1KPTDb0CByVkqV9Nz5baBGN+9BRurcDhlXcUoVQ
         6AJQ2cNODeewp+IF3n+XAhLuq2kLO0qsj4yW4m8YdDVOmQ6UGBMw0XAFpSvCkEYlbR
         wrbgsdvMeBw14HAH43AIIyb3LdYo55MKbAcrJKudvPTG7Z/STi82VjSCdv5G3PCUHB
         zRxZ0G29EIzidIbjeiDnhiseVVbM8OuQuP7NNqDArIC8GxnChN+Y1+0JDdogOx7E4e
         UHc4o3qtkC1/P52Mfdur81wITas5gGHFeDV1JYPewEjusNbPyHz97ZQ7kjSuuubQen
         02rDjE1+Z3o0w==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0100
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 10 Oct 2023 18:25:45 -0700
Date:   Tue, 10 Oct 2023 18:25:45 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [resend PATCH v2 2/2] fuse: ensure that submounts lookup their
 parent
Message-ID: <20231011012545.GA1977@templeofstupid.com>
References: <cover.1696043833.git.kjlx@templeofstupid.com>
 <45778432fba32dce1fb1f5fd13272c89c95c3f52.1696043833.git.kjlx@templeofstupid.com>
 <CAJfpegtOdqeK34CYvBTuVwOzcyZG8hnusiYO05JdbATOxfVMOg@mail.gmail.com>
 <20231010023507.GA1983@templeofstupid.com>
 <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvr0cHj53jSPyBxVZnMpReq_RFhT-P1jv8eUu4pqxt9HA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

On Tue, Oct 10, 2023 at 10:15:38AM +0200, Miklos Szeredi wrote:
> On Tue, 10 Oct 2023 at 04:35, Krister Johansen <kjlx@templeofstupid.com> wrote:
> 
> > If I manually traverse the path to the submount via something like cd
> > and ls from the initial mount namespace, it'll stay referenced until I
> > run a umount for the automounted path.  I'm reasonably sure it's the
> > container setup that's causing the detaching.
> 
> Okay.  Can you please try the attached test patch.  It's not a proper
> solution, but I think it's the right direction.

Thanks, I tested this patch and was unable to reproduce the scenario
where an OOM resulted in the submount from the guest in the guest
getting an EBADF from virtiofsd.  (I did generate OOMs, though).

I am curious what you have in mind in order to move this towards a
proper fix?  I shied away from the approach of stealing a nlookup from
mp_fi beacuse it wasn't clear that I could always count on the nlookup
in the parent staying positive.  E.g. I was afraid I was either going to
not have enough nlookups to move to submounts, or trigger a forget from
an exiting container that leads to an EBADF from the initial mount
namespace.

-K

> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 2e4eb7cf26fb..d5f47203dfbc 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1524,6 +1524,18 @@ static int fuse_get_tree_submount(struct fs_context *fsc)
>  		return err;
>  	}
>  
> +	spin_lock(&mp_fi->lock);
> +	if (mp_fi->nlookup) {
> +		struct fuse_inode *fi = get_fuse_inode(d_inode(sb->s_root));
> +		mp_fi->nlookup--;
> +		spin_unlock(&mp_fi->lock);
> +		spin_lock(&fi->lock);
> +		fi->nlookup++;
> +		spin_unlock(&fi->lock);
> +	} else {
> +		spin_unlock(&mp_fi->lock);
> +	}
> +
>  	down_write(&fc->killsb);
>  	list_add_tail(&fm->fc_entry, &fc->mounts);
>  	up_write(&fc->killsb);
