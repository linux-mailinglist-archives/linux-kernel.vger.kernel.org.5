Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3C79777E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjIGQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbjIGQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD09F46A9;
        Thu,  7 Sep 2023 09:23:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A911C433C9;
        Thu,  7 Sep 2023 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694103379;
        bh=FoAGFCr9du8GZdsxYZ79Z15sdeHUYWMrj5BE0Jr4WIg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LMWZeGfzBdgQIj+MP1F7vvYmJ6tNU73iYiF1QUxiNQNCqIVWzld+XcqJLScJEyZI/
         vYzh9aSDGMHnu33jsBA+DlQhVd3WpTr9/c6yVFf7KbQGrt7b5zlAj5guUPf1S6H/Mk
         Vm6SzWlGbdj+VDu7Vx1rnDFWUpfrgmbXCZPZm3Ir7X6yqcQCfvFs5rb97iItOWgt9H
         eeY5nTlWhiiiarcWa42RcqxFg3Namr77yPs3sVjiL3YEkwDK1dT3+16OQnZcZV83yU
         mrAVrRKgiYoqc8ifxNkEeFCna9raGHxWxzqDxBmFQLNh9qE9dTv9btV0TI8rAT5seb
         UdGGoa2c9pCfQ==
Message-ID: <3cc438c8-295e-461b-a842-c6d0f268fe9e@kernel.org>
Date:   Thu, 7 Sep 2023 18:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add qcom hvc/shmem transport
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20230718160833.36397-1-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2023 18:08, Nikunj Kela wrote:
> This change introduce a new transport channel for Qualcomm virtual
> platforms. The transport is mechanically similar to ARM_SCMI_TRANSPORT_SMC.
> The difference between the two transports is that a parameter is passed in
> the hypervisor call to identify which doorbell to assert. This parameter is
> dynamically generated at runtime on the device and insuitable to pass via
> the devicetree.
> 
> The function ID and parameter are stored by firmware in the shmem region.
> 
> This has been tested on ARM64 virtual Qualcomm platform.
What can we test it on?

Konrad
