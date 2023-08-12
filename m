Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50FF77A143
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjHLRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 13:11:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5A1E4D;
        Sat, 12 Aug 2023 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qob9GvmfgPfkS28nsR/UdlyRcMxaMz2yJgxRzfLFVrk=; b=N1mraUYZ6TaB5IgBpdq0jiHHpC
        F/8w1Mnc6nU+VnA7uYU8orhpmK27grB/wZOiGSm29tIhOPoX1dq3HCwbPeCgIwI9WyOESZJblu8RV
        1uRRVWZCrKiDX90zdrfOPMCFF2MHz6UcgFY6grZtDzspB8Aq7DV4rbbxEjppCPyek0bQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qUs9F-003v4p-2T; Sat, 12 Aug 2023 19:11:33 +0200
Date:   Sat, 12 Aug 2023 19:11:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] soc: qcom: aoss: Add debugfs interface for
 sending messages
Message-ID: <6ea7796f-9d31-49a5-849e-3a52d35e26ea@lunn.ch>
References: <20230811205839.727373-1-quic_bjorande@quicinc.com>
 <20230811205839.727373-3-quic_bjorande@quicinc.com>
 <d212e5a7-e9e5-4297-85fb-030818f7c647@lunn.ch>
 <20230811233228.GT1428172@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811233228.GT1428172@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As mentioned in the cover letter, I do recognize your concern here. I
> don't see it as a realistic way to work around the kernel for reasons of
> being proprietary - given that we don't have debugfs mounted in the vast
> majority of product.

Look around. How many drivers do you see which allow passing binary
blobs to firmware?

      Andrew
