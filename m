Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772D0800A0F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378606AbjLALtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378585AbjLALtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:49:06 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B931170E;
        Fri,  1 Dec 2023 03:49:08 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 264AC20645;
        Fri,  1 Dec 2023 12:49:06 +0100 (CET)
Date:   Fri, 1 Dec 2023 12:49:04 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
        tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 00/12] wifi: mwifiex: added code to support host mlme.
Message-ID: <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-1-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lin,
thanks for the patches here, I can clearly see that this code is going
through some real testing given the improvements you did lately.

I have commented on the single patches, and honestly I did not look into
the code details at the moment.

The major feedback from me is the following:
 1 - you should not add code with a bug and than fix a bug in the same
     series, you should have a non buggy patch in the first place (e.g.
     git --amend). (this applies till the patch is not merged into the
     maintainer tree, of course).
 2 - point 1 applies also to reviewer comments
 3 - if you have fixes that are not connected to the feature addition
     you are doing is beneficial to have those separated, this makes
     reviewing easier, they can be "prioritized" to some extent (given
     that they are fixes) and follow a slightly different patch flow
     (they can get applied, depending on the maintainers decision, when the
     merge window is closed and should be backported). Not to mention
     that smaller patch series are appreciated, "Maximum of 7-12 patches
     per patchset " from [1]

In general I would suggest you to have a look at [1], not sure how up to
date is that compared to the in-tree Documentation/process/.

On Tue, Nov 28, 2023 at 04:31:03PM +0800, David Lin wrote:
> 5. Address reviewer comments.
You should list the changes you did, something that generic is forcing
the reviewer to compare v7 vs v6 to known what changed.


[1] https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Francesco

