Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF89F777F99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbjHJRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjHJRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:51:17 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA5FE53;
        Thu, 10 Aug 2023 10:51:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AHpAkh109642;
        Thu, 10 Aug 2023 12:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691689870;
        bh=AJ3MlJvwj0px0YqPXhnfXqEFuxwy22n787atbwLH+QA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=a1GQC+CjGJnkB9hrg0iJTRFltKeX3lfoehPCfBRaB8mIhjR4TCMfyfys555vruaSM
         1mhHb6XTj4D+5k4KPwfS+u3EcWU2InD1PIZQT8uJo/UKGDZUejXNT0hFQoQAIJ7upQ
         Xib1odXPxkUSQFkdA5WhbgwF2jDXr2uiRRP0Mqa0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AHpAlC080075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 12:51:10 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 12:51:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 12:51:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AHpAvE066023;
        Thu, 10 Aug 2023 12:51:10 -0500
Date:   Thu, 10 Aug 2023 12:51:10 -0500
From:   reidt <reidt@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-*: fix fss node dtbs check warnings
Message-ID: <20230810175110.4ddqz4xc756betvk@reidt-HP-Z2>
References: <20230810081847.277094-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810081847.277094-1-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:48-20230810, Dhruva Gole wrote:
> Fix these fss node warnings that dtbs_check throws:
> 
> fss@47000000: $nodename:0: 'fss@47000000' does not match
> '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
> 
> By renaming fss to bus.
> 
> Cc: Nishant Menon <nm@ti.com>
> Suggested-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>
Reviewed-by: Reid Tonking <reidt@ti.com>
