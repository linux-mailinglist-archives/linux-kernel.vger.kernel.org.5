Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF87DD5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJaSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjJaSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:21:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB5A6;
        Tue, 31 Oct 2023 11:21:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E71C433C8;
        Tue, 31 Oct 2023 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698776475;
        bh=o18vwaeO2R36/vbyGopKWMEkawn3UVBm6qFsz82W5YI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I8MBAcAJPkzoHLFjXMEloJwiM/7wimzAfmbxD83KW+cC7avlJB9q4JQuHfg5LhPyT
         anBo1h+8CEJJ5qgX0UsK0FgrbQF0r7XJprBgsCoLm531DVwCe4WRYfto6u5jWZiZL7
         aT3z17ps/46SatgUYjIMd8jPRJe8ZfcAen/zMThUhyb/SlmtcxeTyw9NDm6vDtz29D
         dZQgq6sS5wlJxs6QgdzepKEu/nnTnJCu2dseeZ62PbXKVHobmrzfMdTqjssa3wytZl
         NCbW8foBsRd4QEzc42BrgihiaW/LsntsTG+2GiFFxWlB541tE1ZztVaL2QxBdg9h9E
         GTSytXb6asd9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 92E30CE0B77; Tue, 31 Oct 2023 11:21:14 -0700 (PDT)
Date:   Tue, 31 Oct 2023 11:21:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] refscale: Optimize process_durations()
Message-ID: <bcd6bfe1-9891-4f22-86ad-361330e47e9d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bbbab32e3e104bdc2238724a6a4a85e539f49ddd.1698512661.git.christophe.jaillet@wanadoo.fr>
 <ozbrmbywamyfkv3amsf2dfdacwmi25serwhc75h6fpsahklsmo@rm43srgxumef>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ozbrmbywamyfkv3amsf2dfdacwmi25serwhc75h6fpsahklsmo@rm43srgxumef>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:55:16AM -0700, Davidlohr Bueso wrote:
> On Sat, 28 Oct 2023, Christophe JAILLET wrote:
> 
> > process_durations() is not a hot path, but there is no good reason to
> > iterate over and over the data already in 'buf'.
> > 
> > Using a seq_buf saves some useless strcat() and the need of a temp buffer.
> > Data is written directly at the correct place.
> 
> Makes sense.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Queued and pushed, thank you all!

							Thanx, Paul
