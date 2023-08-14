Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16D377B54E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjHNJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjHNJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFD2D7;
        Mon, 14 Aug 2023 02:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF62D63080;
        Mon, 14 Aug 2023 09:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245F5C433C7;
        Mon, 14 Aug 2023 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004909;
        bh=PgX2A+ccGYe4/wQfUKl5YuSHuvpxj/bPRazdogtCW4w=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=dP4OkEt/Pvu133FDZEXWTd9Di5XCd9n4DOo3B3p8ryE4jk+wPNkPEBDaYtrhkM0iW
         r9n4AposCWCC58b6w9t0+UOb2vxkc4X/NPT1FVBpRItCcjOWPf5FxRIGIltEvRC5T+
         CNbAnS98rbFGCoE7pm0l3IeItbdo5BzMrb6UqjURE7PJ5QwMM8OcAOGBx08SM9h0VX
         KhRe1NJvJVv4qftWWCvaeMmHhbwrDoeB+x53KnDl9jqOUeukBvJPMB0fjKUycCW+Ev
         DFi66D1Z4xjo3xI48116+/T+4+Z3f3rMxABsT9dqOcSgEFnHdJtHdrE108I6t0/n4J
         SFztE5nkjCHtQ==
Date:   Mon, 14 Aug 2023 11:21:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: Reorder fields in 'struct hid_input'
In-Reply-To: <9accb4ebd1247e2f2acc77dd053f67e60bf8d283.1687079502.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2308141121370.14207@cbobk.fhfr.pm>
References: <9accb4ebd1247e2f2acc77dd053f67e60bf8d283.1687079502.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2023, Christophe JAILLET wrote:

> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct hid_input'
> from 72 to 64 bytes.
> 
> It saves a few bytes of memory and is more cache-line friendly.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

