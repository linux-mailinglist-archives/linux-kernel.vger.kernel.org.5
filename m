Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4743580E8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbjLLKSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjLLKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:18:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E02A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:18:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E53C433C7;
        Tue, 12 Dec 2023 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702376335;
        bh=BDA09IhOdJW1cajZlzV19+AKYjAHgvythLG7ITpYD98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opux/XgfjUHFZVdwwdF32fgT8kROdV23JLpSodnxXNW1p9Ts2iGOQvYSKzLcpvGvx
         G2vB9h093GLyD1BSff6rqzZWok2ekTyi0z9QqE+vVFZJKI2erjVidH3ri/MrB9Qng+
         ap6y2Vqm/q2f1W0q2y/Wyb2ML5IX83HpvAnb3TvjfTDTraqKCpjLIOxIzZYUK3tU4q
         +AKtQnX/JfXUyBXgKJDThmSQZS+b18SqxrG2TfCLKxR0vidNMQTsz6mv89AZrWRXoO
         k0ngUxsjIqqO+g/UkpsRmNY9dRd3gVH/TNyJ9r0KAwGjabnzjHFXwk4WWEmLdf98Eu
         COTdTV31JHAKA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh@kernel.org,
        roy.zang@nxp.com
Subject: Re: [PATCH v6 0/4] PCI: layerscape: Add suspend/resume support for ls1043 and ls1021
Date:   Tue, 12 Dec 2023 11:18:47 +0100
Message-Id: <170237631077.45230.13455897797263324456.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204160829.2498703-1-Frank.Li@nxp.com>
References: <20231204160829.2498703-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 11:08:25 -0500, Frank Li wrote:
> Add suspend/resume support for ls1043 and ls1021.
> 
> Change log see each patch
> 
> Frank Li (4):
>   PCI: layerscape: Add function pointer for exit_from_l2()
>   PCI: layerscape: Add suspend/resume for ls1021a
>   PCI: layerscape(ep): Rename pf_* as pf_lut_*
>   PCI: layerscape: Add suspend/resume for ls1043a
> 
> [...]

Applied to controller/layerscape, thanks!

[1/4] PCI: layerscape: Add function pointer for exit_from_l2()
      https://git.kernel.org/pci/pci/c/123971a193d9
[2/4] PCI: layerscape: Add suspend/resume for ls1021a
      https://git.kernel.org/pci/pci/c/6f8a41ba2623
[3/4] PCI: layerscape(ep): Rename pf_* as pf_lut_*
      https://git.kernel.org/pci/pci/c/762ef94b45d9
[4/4] PCI: layerscape: Add suspend/resume for ls1043a
      https://git.kernel.org/pci/pci/c/27b3bcbf8a79

Thanks,
Lorenzo
