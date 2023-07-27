Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE87648EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjG0Hj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjG0HjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:39:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7873A85;
        Thu, 27 Jul 2023 00:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6981161D72;
        Thu, 27 Jul 2023 07:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49C2C433C7;
        Thu, 27 Jul 2023 07:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690443009;
        bh=gWhi/9Qxe2NDYAZVYaCS9AqWMgoFXgOS7cdoZtkVZPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qr1lSZ+uWkfJmmOwv3kuWP6nAhYBqQ2dTpdWD5Ub7Un6G9NIREwsDVZaGfQcRjdlC
         w1QcA2ynb1NF1JTDhIyJ89HEQm6RzOWSciDT3/R57jXr97K6Xk3tTeYWDpkOAGemti
         3hO7d0P3CAcc9Q5qsZEmzBu0LxRvap/MXayenb/3j9DfXLFksUxVk7hEX7LXNfi7SV
         z4IcMQg0iARxuv9uXuJD44acqEjGQS7HRDk64tIk0YI78BtABmItsPaptJdiXEVbZW
         L6hsbJKoiYgD+7pkp9YHtTD833e9PeccwYpjAqfWJXjN6QBpHda/VPoSobFUoR6z5u
         iez7SRhwWR/YQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOvS7-0008VG-2r;
        Thu, 27 Jul 2023 09:30:27 +0200
Date:   Thu, 27 Jul 2023 09:30:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hemantg@quicinc.com
Subject: Re: [PATCH v13 2/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZMIdE1ffQEmFMC8V@hovoldconsulting.com>
References: <20230727044011.965205-1-quic_tjiang@quicinc.com>
 <20230727044011.965205-3-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727044011.965205-3-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 12:40:11PM +0800, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and NVM downloading.
> as the RF performance of QCA2066 SOC chip from different foundries may
> vary. Therefore we use different NVM to configure them based on board ID.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
 
> @@ -1931,6 +1934,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
>  	.num_vregs = 4,
>  };
>  
> +static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
> +	.soc_type = QCA_QCA2066,
> +	.num_vregs = 0,
> +};
> +
> +

Stray newline.

>  static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>  	.soc_type = QCA_QCA6390,
>  	.num_vregs = 0,

Johan
