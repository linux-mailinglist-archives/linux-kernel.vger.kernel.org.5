Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D09770663
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjHDQy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHDQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B049F0;
        Fri,  4 Aug 2023 09:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A51062097;
        Fri,  4 Aug 2023 16:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE408C433C8;
        Fri,  4 Aug 2023 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691168062;
        bh=glKsCrTO4KRcRTPJpniA/p1bjsyxrbPDbXj3kg6LpPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkHbUORVg//4gaSC2sQytx4/5RwamYfKlVN+9bO6WE8r7c/u8E8Ipv6e5Gs9i3hI2
         PODKC05uadCdTWcgTrlP+9aSvHM+hJSso0UqsKnIqbk5hLSXfmvJYGaaRz6dVqu7ED
         Hv4sFSMKRoRMqq+zwVqmGK9ZWsaUKuoOgiYbIFl/xORBGSqQjLL/IVOvtVP9JrWWq7
         JvhBPzj9ns3R7dATTJCbwHdQL27IfezwR60+B9+CsKxb0N7dyjZKddJgKYRQgwqg7l
         DgrY+FoPxITtG0O+N6SQONjga9lQA/BgoVblbOiprOiZ421XtDg0zG4UYmf3LAnver
         HAHMZEGbavO7w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qRy4B-0005di-1c;
        Fri, 04 Aug 2023 18:54:19 +0200
Date:   Fri, 4 Aug 2023 18:54:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] firmware: Add support for Qualcomm UEFI Secure
 Application
Message-ID: <ZM0tO1K4yuBdK6pa@hovoldconsulting.com>
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-4-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730161906.606163-4-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 06:19:04PM +0200, Maximilian Luz wrote:
 
> +config QCOM_QSEECOM_UEFISECAPP
> +	bool "Qualcomm SEE UEFI Secure App client driver"
> +	depends on QCOM_SCM

No need for this one.

> +	depends on QCOM_QSEECOM
> +	depends on EFI

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
