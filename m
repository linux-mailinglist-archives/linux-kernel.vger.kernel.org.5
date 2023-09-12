Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814AD79D3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjILOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjILOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:37:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7A610D;
        Tue, 12 Sep 2023 07:37:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A878C433C7;
        Tue, 12 Sep 2023 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694529461;
        bh=seZ6bO2O8khY6IiLFbM8+idr9y7j2e+ADHMa7vktAEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THANbBEBHj2+bi3aQdqBFY9j9RePLe9TwkgGsmWadUn4ykiigSzcNk4gfJC060MIP
         k7aUYHwJvJFGR/GmAaVw7x1p4qQUep0DJiR+pknPIq3ugBIkvESOX4UwmYvXStf7f3
         UMGj9r35tBb2ROvI72inVtvvgxcF5yd+NzmIp2CCe4EFAcioSu4IGncTt+3BQzxKB3
         QVLOEDs4hZjiZrINFCjX+d9cYzvWluTDY0xv9e8Zfed+ol38THmFcBAT8DvRPx5b+7
         g8dSxrbrpICJljZly28FU+J+x1jviKW+vnh8yzXl85qL27por6mihI5k5lWsqOrETz
         /W2YnPqoh2fug==
Date:   Tue, 12 Sep 2023 20:07:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, quic_charante@quicinc.com,
        quic_kaushalk@quicinc.com, quic_pkondeti@quicinc.com
Subject: Re: [PATCH v4] mtd: rawnand: qcom: Unmap the right resource upon
 probe failure
Message-ID: <20230912143726.GE6404@thinkpad>
References: <20230912115903.1007-1-quic_bibekkum@quicinc.com>
 <20230912142847.4610c0a0@xps-13>
 <5e80e600-b523-476a-81bd-93d2c517b7b6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e80e600-b523-476a-81bd-93d2c517b7b6@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:02:07PM +0530, Bibek Kumar Patro wrote:
> 
> 
> On 9/12/2023 5:58 PM, Miquel Raynal wrote:
> > > We currently provide the physical address of the DMA region
> > > rather than the output of dma_map_resource() which is obviously wrong.
> > > 
> > > Fixes: 7330fc505af4 ("mtd: rawnand: qcom: stop using phys_to_dma()")
> > Cc: stable?
> Cc: stable@vger.kernel.org

You need to send another version adding the CC tag.

With the tag added,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
