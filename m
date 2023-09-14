Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD87A017A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbjINKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbjINKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:18:33 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA38E1BE3;
        Thu, 14 Sep 2023 03:18:28 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RmYDv5p6dzyWJ;
        Thu, 14 Sep 2023 13:18:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1694686705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icMC27BzeY6SN2EXUotyJ+BK0dx4eNWCSZ4I3xj8aTU=;
        b=Y2QiSpib/nAQz+mKuXKs+r1Z1KuNVM3UnVSYLwbGY3GpsUNP9kTysIyIAmy4MQ0I4Gpixq
        1Z2JQI3uDZr2GmAoOUS3RXMo2EtgVifZWO/X7aqwMRs1BVupM22cdSYJGQkgFIlcYlqgs1
        bmuEjgrpiysRkdMfO5X5VhwF1fJP3c8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1694686705; a=rsa-sha256; cv=none;
        b=qfZMJHDuh+FhXq0zZ2Z8UMQ5hPrIuU7qjPTUVsOrRuDRqdrM6EhP1kv50wKUN8q3WCcFw0
        CnN3uJIaN9iV4NP8TOWl3f3nfZj5CBzByU2NfmT8KQiFBT153HGlk3FEM7bk3tLX7K4TQF
        Sk0rhQemWDPacjUZXOek5E6tfbg1eL0=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1694686705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icMC27BzeY6SN2EXUotyJ+BK0dx4eNWCSZ4I3xj8aTU=;
        b=FGXPkUyP4O7zvZ+QxqaxvSriyG8lYJ6HhucxNmEB9g/jwSKMlJQxmgyhYI+8TGe9F4Dfsu
        dtpoGTwl81ygLlC+dMD9mR0NoTb1fszmbNxZ+DFyyMnFx3TUHIHLQrA1Owo/Jlgo03+yzI
        Sba4mDPowWJ9V57fWhSAWyWKPG/3m1w=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 54800634C93;
        Thu, 14 Sep 2023 13:18:23 +0300 (EEST)
Date:   Thu, 14 Sep 2023 10:18:23 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Conor Dooley <conor@kernel.org>
Cc:     Fabio Estevam <festevam@denx.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: media: Add OV5642
Message-ID: <ZQLd74RoAyx8S1d2@valkosipuli.retiisi.eu>
References: <20230802160326.293420-1-festevam@denx.de>
 <ZQHbm4K6tDs6ILo+@valkosipuli.retiisi.eu>
 <19523723a202647d0ab5135581f5090f@denx.de>
 <20230913-undocked-geek-757dddbbabd7@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-undocked-geek-757dddbbabd7@spud>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 07:26:48PM +0100, Conor Dooley wrote:
> On Wed, Sep 13, 2023 at 01:04:06PM -0300, Fabio Estevam wrote:
> > Hi Sakari,
> > 
> > On 13/09/2023 12:56, Sakari Ailus wrote:
> > 
> > > One more little thing. Do you have a driver for this device? In upstream
> > > there doesn't seem to be any.
> > 
> > Correct. There is no driver for OV5642 upstream.
> > 
> > The DT folks asked me to document the OV5642 binding even without an
> > existing driver.
> 
> IIRC, Fabio wanted to delete it from trivial-devices, and Krzysztof and
> I both felt it was more suitable to document it properly rather than
> delete it.

Ack, works for me.

-- 
Sakari Ailus
