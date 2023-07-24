Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4793275F3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGXKrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGXKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:47:05 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D459C;
        Mon, 24 Jul 2023 03:47:03 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R8cKv30xJz9t3y;
        Mon, 24 Jul 2023 12:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1690195619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRgDsdj4PRaBX4F+5NuwghTRwQQTxR0MoJRVxO8TmDM=;
        b=hJZVWzSGSd27nZkk+77PknK0vznvbxJ0/csknIDZKtbuqocbGowTgvDTRp5kHwHq8VTNcN
        sI6IlW31o4Bg7agxOLgIQv1FsKLi00x1uQSyGLFRClbvZZ6TctRU4GzTt+AYihA62RE90E
        8XoFTkdBXcRTITTVEEo8fa6PVq1Ug8zpqfzpnl4s/ZNyaV3lsfbncy16bsE0CGkN8y/xRp
        GPdV0do0y4x+rT3b8fXqrISxwuL1j7sA3ewktGWABKEQxBdgD5hkQ/O0FQr2vlP/cI//4b
        pRZHonfpIKk3994LbXC9WTO5Jtz06jIpRC5JGawPh2npyTY2EwJKBdM6nJ6F4A==
Message-ID: <a31d3d49-1861-19a2-2bb4-8793c8eabee9@mailbox.org>
Date:   Mon, 24 Jul 2023 12:46:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH AUTOSEL 6.1 28/41] Revert "drm/amd/display: Do not set drr
 on pipe commit"
Content-Language: en-CA
To:     Sasha Levin <sashal@kernel.org>
Cc:     Dmytro.Laktyushkin@amd.com, dri-devel@lists.freedesktop.org,
        Wesley.Chalmers@amd.com, sunpeng.li@amd.com, qingqing.zhuo@amd.com,
        Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
        airlied@linux.ie, Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>, daniel@ffwll.ch,
        wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        hugo.hu@amd.com, harry.wentland@amd.com, christian.koenig@amd.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230724012118.2316073-1-sashal@kernel.org>
 <20230724012118.2316073-28-sashal@kernel.org>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230724012118.2316073-28-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 324e36e7dfef5be2138
X-MBO-RS-META: ugp96btdxp5iatie16dfbs8fg661iw7g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/23 03:21, Sasha Levin wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> [ Upstream commit 8e1b45c578b799510f9a01a9745a737e74f43cb1 ]
> 
> This reverts commit 474f01015ffdb74e01c2eb3584a2822c64e7b2be.

The reverted commit is the same as patch 1 in this series...

Same issue with the autosel patches for 6.4.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

