Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4D87810C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378894AbjHRQp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378874AbjHRQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2D4223
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC9963C79
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C606C433C7;
        Fri, 18 Aug 2023 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692377087;
        bh=mrxAO1shKb7UqXSsACvG9y6cbGRxvmxr12K2Oyt47vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpD6I1BgUfrUkx57XgagopR3kIoJjal8y3L2fiJrFDGQ33y37/7NcQEAiZfSlTdMb
         yUpyAkUAyM6pgQtJZeBaddwFbnIErNZo04/CqE5gXUHFK9HcYCQbTkYh0zx4s02AQu
         EJWmfbQrdRYiyp3Hcxpv3sbL3XG70N5+7mtDYsa12ktySZT0/ZiGN5VFRrebcEBIgq
         igobGfjIt3xSgPFoPgf9UnbM7hiqahawP6vQYWgmltKeDxGem0tLZ4eRVVH0hKpdmK
         Jsvo0SBrP/2WjSGdBNiR1/h8FLzuWNrN83B0MOiH3i2Enva6BGXLBUXZqO8iLWsJeX
         JSuggbNPl9DLA==
Date:   Fri, 18 Aug 2023 17:44:43 +0100
From:   Lee Jones <lee@kernel.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, werneazc@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: (subset) [PATCH v2 1/2] mfd: (tps65086): Read DEVICE ID register
 1 from device
Message-ID: <20230818164443.GD986605@google.com>
References: <20230818083721.29790-2-andre.werner@systec-electronic.com>
 <169237658196.1308508.13955700873692765066.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169237658196.1308508.13955700873692765066.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023, Lee Jones wrote:

> On Fri, 18 Aug 2023 10:37:21 +0200, werneazc@gmail.com wrote:
> > This commit prepares a following commit for the regulator part of the MFD.
> > The driver should support different device chips that differ in their
> > register definitions, for instance to control LDOA1 and SWB2.
> > So it is necessary to use a dedicated regulator description for a
> > specific device variant. Thus, the content from DEVICEID Register 1 is
> > used to choose a dedicated configuration between the different device
> > variants.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] mfd: (tps65086): Read DEVICE ID register 1 from device
>       commit: c957aecacc831c00497ee95c6984e319f7f82229

Note that this is not the correct subject format for this subsystem.

Patch on test - will send a PR for Mark to pull once complete.

-- 
Lee Jones [李琼斯]
