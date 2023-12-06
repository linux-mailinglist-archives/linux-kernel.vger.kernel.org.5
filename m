Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59423807759
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442763AbjLFRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjLFRkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:40:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76887137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:41:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA17C433C7;
        Wed,  6 Dec 2023 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701884460;
        bh=ha/WzCOsQe3G+coUldXRa0OE2YfkZhh+fxESdFI6heA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XiKEqautHbq72b4VhUNaN3Y1psiZAOIoJu8izwzTVqxMfHFSTWaXqr5NItM69xil8
         02YlOLBg0kwJk73sZN2J1S43UT9rV39PbQ+VPW05ojhS1GNfcNR6zmgJqzWfsMdwIj
         WZbYgLsy6L3gIHh7cLChLV8RGNSJcuS9U7xfwLKi1c9kqrnKHz3AU2GpX/8aUtcrri
         +3ZaaMfd5aEJZggjz/joKAb0o5wkokWmesjhyWRVU5cgDSOpouma7O5qC21DPTX+KU
         g9CyCAWyHtk/rxAHzFX+ID4rUC3AM2gxWRbIyZQFhtWgPLKAjRA5Sb15Kkar05ssLP
         XABqbLzga30hA==
Date:   Wed, 6 Dec 2023 17:40:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <20231206174050.12ad1c98@jic23-huawei>
In-Reply-To: <ZW6IqoelmMhTgjgW@abdel>
References: <20231202041651.719963-1-alkuor@gmail.com>
        <20231203-wrecking-sneer-d34f19c39f04@spud>
        <ZW6IqoelmMhTgjgW@abdel>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 21:19:22 -0500
Abdel Alkuor <alkuor@gmail.com> wrote:

> On Sun, Dec 03, 2023 at 11:24:31AM +0000, Conor Dooley wrote:
> > On Fri, Dec 01, 2023 at 11:16:50PM -0500, Abdel Alkuor wrote:  
> > > as6200 is high accuracy temperature sensor of -/+ 0.4C degree  
> >  
> Hi Conor,
> > Is +/- 0.4 degrees really "high accuracy"?
> >  
> That's what the datasheet says :D. I'll remove it.

I'd not noticed this.  Why is this an IIO driver rather than an hwmon one?

Mostly we do that only for very high accuracy or weird temperature sensors
(infrared ones for example or things with complex thermocouple handling).
Simpler devices meant for hardware monitoring type applications typically go
in hwmon.

We have the iio to hwmon bridge driver for things that naturally have uses
where IIO features are needed, but which get used for hwmon sometimes.
Not sure this is enough IIO focused though, so perhaps list out why you
think it should be in IIO?

Jonathan

