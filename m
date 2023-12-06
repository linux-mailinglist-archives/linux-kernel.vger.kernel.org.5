Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF34806F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377982AbjLFMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377870AbjLFMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:10:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9671BD;
        Wed,  6 Dec 2023 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=leiOy4pfs2M7Gc5q5SIIOyBYtiFRTNEgwnrs/Ad5pAc=; b=yqoCcLppPJTBsAE3D8LSk+hlFa
        XTvoZx7fDjty1f96GFi7c/aSmmdqS+CIZrp0j2gds1FCZnpK69YVk6Tptc/0HF1rWFrK/6S8LCmRE
        LjU6+Jcmw3kTjRcp40nn+dfetAavwOrIk2xn30qxw7a6Hx0RMIwLeRGNWu4CYdE75QwaiqoZXYYYw
        evYhOB58/PP6Af/LOUoqCjSPGjxkiVrH2ERem72TqvXs601wg7yGzxkEQLg2wafHglC130cXvPhVY
        ZjxRvag9C31bvyV3CbE7FIALTOlVJpWSeAEMhcrCuC3pmGMR6oq3/JU6kOl02AFTbtd6z8ASQpv0b
        8ubIIDUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAqj9-00ADve-2q;
        Wed, 06 Dec 2023 12:10:07 +0000
Date:   Wed, 6 Dec 2023 04:10:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V2] scsi: ufs: core: store min and max clk freq from OPP
 table
Message-ID: <ZXBkn/VkkTSDtknP@infradead.org>
References: <20231206114659.13009-1-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206114659.13009-1-quic_nitirawa@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:16:59PM +0530, Nitin Rawat wrote:
> But these values are used by the vendor host drivers internally for

There is no such thing as a "vendor" driver.  Please be precise with
your wording.

