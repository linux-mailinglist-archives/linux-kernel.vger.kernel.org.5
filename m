Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880F782A86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjHUN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjHUN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:29:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72264A8;
        Mon, 21 Aug 2023 06:29:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107CC6373C;
        Mon, 21 Aug 2023 13:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD4BC433C8;
        Mon, 21 Aug 2023 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692624572;
        bh=fSfkleXtNPj98d5b1azTlZSdZRBfJtnFl1WtA8fTpRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paC4E0fkT/z5I0yHawolGIex2U3OfGFyvI8vSgjX1Y8ghvyX0zZJIVT4HX4rHAAi4
         QyVHKFHUScuNpNnrYfGGvNwOVuMkfNztA/BqmEoeGg2APaAd3an3E0nITqhshFct3x
         Ps5Fm8/ex74ml9qhJAhbYA8ZVO0sAqYnhFbFWbgzYclDxxoksRBxvnLBxF+/VcTBSS
         11+zQkiqJxWtc3ZBq9McQ8uqeIdw0VMOIk7spV/Z3NYoIXoixbaFb/qb9IAfV4HEgX
         ZPZ2x9yMWczzit2pJ5Pz03J37B6tIYocq+d4Ljbvz3L1WOLFHvKv8DqAy7g/k/7u2j
         IHmPyDesc758Q==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qY4yG-0000j4-1k;
        Mon, 21 Aug 2023 15:29:28 +0200
Date:   Mon, 21 Aug 2023 15:29:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Message-ID: <ZONmuKhShSxBUHZH@hovoldconsulting.com>
References: <20230809073432.4193-1-johan+linaro@kernel.org>
 <42f78c02-1ddc-cf1c-694f-abf9059dfb60@quicinc.com>
 <ZNNZVsFb3_Dt_NMb@hovoldconsulting.com>
 <25b778d4-81dc-506b-47f1-e9f16d49682f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b778d4-81dc-506b-47f1-e9f16d49682f@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:16:21AM +0530, Manikanta Pubbisetty wrote:

> Also it is worth to give a try with this patch here https://patchwork.kernel.org/project/linux-wireless/patch/20230601033840.2997-1-quic_bqiang@quicinc.com/
> . This seems to be fixing some known interrupt issue on WCN6855. Could you
> pls give a try?

That patch makes no difference as the X13s use multiple MSIs (so
ath11k_pci_set_irq_affinity_hint() is a noop).

Johan
