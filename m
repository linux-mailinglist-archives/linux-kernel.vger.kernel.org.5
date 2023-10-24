Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B57D4856
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJXHUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjJXHUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:20:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B712B;
        Tue, 24 Oct 2023 00:20:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027F5C433C7;
        Tue, 24 Oct 2023 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698132006;
        bh=60uKQEnj+93gHj83QGt3xD3fa/pnl7xAR/0kIcMK5Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l7bVa0LLh1mM6loLdouR/d1wOr/VFp+xdHbHGUmM1PZIyK6TmAQvUKAOo+okCrANL
         xDuvbDhSsKgfAS7NodEIXCmt8W3GhHj5whbbBktaOI2ocYfyGbTlsE4pgenKjKJt9V
         ujbSfC5+46qmFgJNO9OREmyVm79QVdnq8G0ymY6mnMwFj/SJ/OhLMflhyf2iVKpDjY
         KEdiRjWK1OZdosQdOmzFppLRP3X3CpcFMLpdh7vRzhCzQWdA8M1kdxHzPL70aXwo0s
         E2iDQPBwF0FiNt6igJvdXHXYV6tEqDgBjkfLdR6PTMHoPIVxBpe51okiuAfmPW6QLc
         qiS1+MhFcBPrg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvBi9-0003gD-34;
        Tue, 24 Oct 2023 09:20:22 +0200
Date:   Tue, 24 Oct 2023 09:20:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 09/10] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Message-ID: <ZTdwNSvi1FJ5TNg3@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-10-quic_kriskura@quicinc.com>
 <ZTad-_toGkumYx6O@hovoldconsulting.com>
 <faa647ed-9692-4233-b421-b9e6271f8934@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa647ed-9692-4233-b421-b9e6271f8934@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:12:40PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/23/2023 9:53 PM, Johan Hovold wrote:
> > On Sat, Oct 07, 2023 at 09:18:05PM +0530, Krishna Kurapati wrote:

> >> +	usb2_en_state: usb2-en-state {
> > 
> > No need to include '_state' in the labels.
> > 
> Any specific reason ? I have no problem if removing the suffix but just 
> wanted to know the reason.

For consistency with the rest of the sc8280xp devicetree sources
(including this file) where we've used that pattern (e.g. as reproducing
"state" in the label is mostly redundant). For example:

	pcie2a_default: pcie2a-default-state {}

and

	nvme_reg_en: nvme-reg-en-state {}

Johan
