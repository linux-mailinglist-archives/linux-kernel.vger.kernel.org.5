Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B557FCDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376857AbjK2D6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjK2D6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:58:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC09D19A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:58:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E620C433C9;
        Wed, 29 Nov 2023 03:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701230292;
        bh=pTybYc9tif82m6rvKK0P6WNpbwK/7q1cBpB8C582wDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iH0PQrWJfV0Xc1bTlcNd7f77++W/SvVxhzI13J6J5xiDiCMAokvs5iPE/oBh4FuIQ
         BhaiDCNVUYez7eIkWx59lyyyVzbZlmxy4SxuKoI7ljmfwtbyn0Prdu+LBF7cQBPOY1
         O2CHLC3PWgk30wPnXKMryQcmsWbgs9EvlGMw0zVhUPbAHzVTvVMrCP1MoTqq2FDjSf
         VemDDctfjRbaEqcKVbanRipoiifMuf32aHJ7CmKR/pTxpAYmZTqEL0g2V2I4dHxAZ/
         ohR2CJ7ki5x0saLWlk4RmzHS7jt82/M/8/01ksk/FITIxFVv1NYe3kM6UjrAV9rRRL
         o6PKsd98Sszrw==
Date:   Tue, 28 Nov 2023 19:58:11 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for
 the measured external offset
Message-ID: <20231128195811.06bd301d@kernel.org>
In-Reply-To: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 15:01:29 -0500 Min Li wrote:
> This change is for the PHC devices that can measure the phase offset
> between PHC signal and the external signal, such as the 1PPS signal of
> GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> the existing ptp_extts_event so that application such as ts2phc can
> poll the external offset the same way as extts. Hence, ts2phc can use
> the offset to achieve the alignment between PHC and the external signal
> by the help of either SW or HW filters.

Does not apply to net-next.
-- 
pw-bot: cr
