Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56D3792AEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbjIEQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353937AbjIEInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDEBCCB;
        Tue,  5 Sep 2023 01:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCB660AFA;
        Tue,  5 Sep 2023 08:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6649AC433C8;
        Tue,  5 Sep 2023 08:43:03 +0000 (UTC)
Message-ID: <b756b302-41bc-4e5f-f788-bf61b7f2bae4@xs4all.nl>
Date:   Tue, 5 Sep 2023 10:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 17/18] media: v4l2: Add DELETE_BUFS ioctl
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230901124414.48497-1-benjamin.gaignard@collabora.com>
 <20230901124414.48497-18-benjamin.gaignard@collabora.com>
 <814130d1-8597-d567-ddea-cb82cadea00f@xs4all.nl>
In-Reply-To: <814130d1-8597-d567-ddea-cb82cadea00f@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 10:17, Hans Verkuil wrote:

> 
> You need much more extensive compliance checks for this, esp. mixing
> create_bufs and delete_bufs. And test it with the test-media test script.

This also means that you need to add patches adding delete_bufs support to
vivid, vim2m, vimc, vicodec, visl.

That allows test-media together with v4l2-compliance to do a good job of
regression testing this new ioctl.

Regards,

	Hans
