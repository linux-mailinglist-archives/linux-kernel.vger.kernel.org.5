Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAF7ADB91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjIYPex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjIYPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:34:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4260D90;
        Mon, 25 Sep 2023 08:34:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AC0C433CA;
        Mon, 25 Sep 2023 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695656078;
        bh=Y7OQBC5AEP9R354Curchhk5OGpVdy/FisMGeX/iJKjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVKIbioIyREl1zwTbB6F43J4ZOV5DT9Pn80/aejaOgNdQ6Zb+VS0AtCmNkcRcqHYf
         nvp/AVewxpfGI+h5XlODkJUrEYsOEJBW9DLuBFM3W+KNtn7/HvA0ImYwwcMC/5U4hp
         V4j6FbRLp3BybvJWNmlXvrexp+xuEGgNaCw9Z68+foaliwVubAED7hBuGctMwWZkDf
         LE7A+UOHni0N2S+opZlZr/JN+Fczw1m7xEmSwc9mZIlvCukwuFjxI2taLhC8wgnCVJ
         rbLePRTwyXFgDXJ6dSqlJURKzF7BifJka8AHzlc/8U9CRuUQJYVj0liY9v/S3eFgDw
         tqMQkEUcya4mw==
Received: (nullmailer pid 1412130 invoked by uid 1000);
        Mon, 25 Sep 2023 15:34:34 -0000
Date:   Mon, 25 Sep 2023 10:34:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     mathias.nyman@intel.com, bgoswami@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        konrad.dybcio@linaro.org, Thinh.Nguyen@synopsys.com,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, andersson@kernel.org, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, agross@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v7 23/33] ASoC: dt-bindings: Add Q6USB backend
Message-ID: <169565607344.1412068.10654540784578345179.robh@kernel.org>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-24-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921214843.18450-24-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Sep 2023 14:48:33 -0700, Wesley Cheng wrote:
> Add a dt-binding to describe the definition of enabling the Q6 USB backend
> device for audio offloading.  The node carries information, which is passed
> along to the QC USB SND class driver counterpart.  These parameters will be
> utilized during QMI stream enable requests.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/sound/qcom,q6usb.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

