Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B5762C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGZHFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGZHEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDDA449C;
        Wed, 26 Jul 2023 00:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E3061528;
        Wed, 26 Jul 2023 07:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A108C433C7;
        Wed, 26 Jul 2023 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690354974;
        bh=lHXQIHzrvHwVsw2n8ho3OKgRL8uci99i0feTnOVSPXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldqMKqfu+uSVk/J2jwEuL29Q229yBjLU/PPwJs1j3nmCYIM1QcKUtwlATQ140U8PA
         14OiMJVvfx9UHTvclH0jwM4ARgTDCAZ2YUNUZPjNyKAeTjlNuMcGwRkJhHjZ5eyhHG
         Dr+6Gyw2jH5d/P5EP8blBX7+c3KuygsTVFowAjnEEZ+Qv0kaaaNY2AGPhR4aQEnt6O
         u+olCAGloQKCDRePaqWiINXzZ2NikvEjE13BSwt0TL2rqwrl5jH7qeIPUqfQKKTEVO
         +ptSf5CQhwHT8m3qmO9VShSPvvv8aew/UBPbueNsCwkKgGQ0Rjii39cLiAjmkQW9sm
         J591R745bZWMQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOYYA-0003RY-1L;
        Wed, 26 Jul 2023 09:03:10 +0200
Date:   Wed, 26 Jul 2023 09:03:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com
Subject: Re: [PATCH v12 0/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZMDFLl1iAHrcQkt_@hovoldconsulting.com>
References: <20230726052245.609987-1-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726052245.609987-1-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 01:22:43PM +0800, Tim Jiang wrote:

Thanks for adding the changelog.

You should also add a sentence or two here that describes what the
series does (e.g. just say "This series adds support for ...").

Also make sure to run scripts/get_maintainer.pl on your series. Looks
like you're still missing some maintainers on CC.

You also did not CC at least on person providing review feedback on
earlier versions.

> Changes in v12
>  - fix compile error issue for patch 1/2
> 
> Changes in v11
>  - reverse two patches order
> 
> Changes in v10
>  - break out btsoc type print into seperate patch
> 
> Changes in v2-v9
>  - solve review comments for code style and commit message context

This is not detailed enough for a changelog, but ok, let's forget about
v2-v9 this time, but remember it for your future submissions.

> Tim Jiang (2):
>   Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
>   Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066

As I mentioned elsewhere, these Subjects should be distinct and
summarise what each patch does.

Johan
