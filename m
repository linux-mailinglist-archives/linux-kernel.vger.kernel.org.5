Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221E076AA17
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHAHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjHAHfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C111726
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:35:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E472E614AC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED60CC433C8;
        Tue,  1 Aug 2023 07:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690875337;
        bh=HBR/QxhOhTo15KLjR7Yq1mnUbIOwmusp+ZZLYEEsJJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Au4jdmIAesdeNkU/hqaP1r8gDkTGpiX+pWS4gGogwYVnkp9tzC7ICQYUcLv++DRBK
         2J+srQ81MGUnZm/Q/38lHY6kHSYjUmYsp2Jrga3PLSBl1jBthexou/fZHo1Q+57UJy
         haO4HvSvpNjKZoMmoRRl8e6yo3VF7w0jTXnXKPxA=
Date:   Tue, 1 Aug 2023 09:35:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5qyn5LiW6ZuE?= <oushixiong@kylinos.cn>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= Re: [PATCH] tty: vt: Remove
 some repetitive initialization
Message-ID: <2023080118-trousers-bok-c290@gregkh>
References: <2ieto7pnge9-2iexi15wlvm@nsmail7.0.0--kylin--1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ieto7pnge9-2iexi15wlvm@nsmail7.0.0--kylin--1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:21:04PM +0800, 欧世雄 wrote:

Please do not send html email, the mailing lists reject it.
