Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75E17C5762
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbjJKOuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjJKOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:50:23 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EED92;
        Wed, 11 Oct 2023 07:50:20 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49d8dd34f7bso2317584e0c.3;
        Wed, 11 Oct 2023 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035820; x=1697640620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiR+D71XrrGzsX6kzUglgHVBFJmuDb5NbT7pcSYbF5c=;
        b=izMUnSHp4wLWCR+iNng5aTndHzbwj+dGuyWeo9JJRfq1ewRmhcAMF1em760tgoS9nq
         0Z9Ajx6dc8NqiIz6IyriA2bpUzjqNF+irJrhca/TP/6PYSufmC3FMfVJ06q7M9rwle1T
         6otiUbSbw6arJwwfpfwNoGMrllsyTNge8cC4dhV4bZYya6GprfoWeSI7A2HSIrChlxGX
         Uy7Ugnqo0dxDiqMnJuoEb/F6SPD9qjl7tEsDWp8B0+TYTj8dHcrWh565bINHSvYSzWcy
         Z+WN2WQApIXgtL41V0Jzjavj5/K37fK1Hk64xoou7MFUv6GIyc5RGGTSQnoByn3CfnMm
         szog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035820; x=1697640620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiR+D71XrrGzsX6kzUglgHVBFJmuDb5NbT7pcSYbF5c=;
        b=t2ZTuzk/zM3cD9R9+tX/vSZxR/j1d8jR0w0NX8WO/MEb1s2uXTR+lf7q7bnf47ZXOd
         AHsZnS1m+1WBr26ai0oKX9YKAfBP4Q8SqCzlS1dKi1Gls0TSx0zpvbXzx8IMFh8cVhlb
         EEAMA6tbUkZMcwply0ccJP0n78j69PY6HYM4q4YOO8AVuV7D+V6kciNRk/ONO9VzxHpo
         91xLPqYhhx5J+Sas5aYn4D+nHUGzyi3r5CAP84eMoqKvvemnC/D7kEtLbY79aJ1DQo0R
         DHTd+OFqO0Tj0fSJCfiH7eOI3VF46Rn9AOtNZtu9AvhSA3eDSayDZtfdRpoJJKIeAGk+
         wJUw==
X-Gm-Message-State: AOJu0YxcY7Tu9PE8e6pkBtt1vXfuTZfCj0Muw/JkcUacyOzzU8RBRHGp
        cPl28Mh7usxz3drbcXHSAUI=
X-Google-Smtp-Source: AGHT+IG2WnxDkI8RsVb0UVxjaWgQQHnrpHbCPoFkXoZjHR8EEyn+mcDPUgmVcFuisU/yN7VCFXAUsQ==
X-Received: by 2002:a1f:e246:0:b0:499:dec9:e1a8 with SMTP id z67-20020a1fe246000000b00499dec9e1a8mr17068444vkg.14.1697035819690;
        Wed, 11 Oct 2023 07:50:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y16-20020a05612211b000b0049696582913sm2510821vkn.10.2023.10.11.07.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:50:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Oct 2023 07:50:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/3] regulator: dt-bindings: Add mps,mpq2286
 power-management IC
Message-ID: <aff33fb9-02d5-4ea1-bd4e-1c8853d0cc8d@roeck-us.net>
References: <20231007165803.239718-1-saravanan@linumiz.com>
 <20231007165803.239718-3-saravanan@linumiz.com>
 <84f4692c-5fee-4d00-b537-570f90191d6e@roeck-us.net>
 <1ce9d59e-0938-4448-8279-b8c6e522b26a@linaro.org>
 <154920ff-ad72-43fe-9631-e65ed918a9bb@roeck-us.net>
 <7a964442-80ca-f69a-f1ad-9296cc8f6839@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a964442-80ca-f69a-f1ad-9296cc8f6839@linumiz.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:02:44PM +0530, Saravanan Sekar wrote:
> On 08/10/23 19:22, Guenter Roeck wrote:
> > On Sun, Oct 08, 2023 at 12:40:29PM +0200, Krzysztof Kozlowski wrote:
> > > On 08/10/2023 03:20, Guenter Roeck wrote:
> > > > On Sat, Oct 07, 2023 at 10:28:02PM +0530, Saravanan Sekar wrote:
> > > > > Document mpq2286 power-management IC. Instead of simple 'buck', 'buck0' is
> > > > > used to keep the driver common which handles multiple regulators.
> > > > 
> > > > Sorry for the maybe dumb question, but where can I find the driver
> > > > depencency on buck naming ?
> > > 
> > > I guess it is because:
> > > PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
> > > creates regulator name as buck+id (so buck0).
> > > 
> > 
> > Ah, good point. Problem here is that this is already kind of common,
> > even though the use of "buckX" isn't. Look for "vout0", or
> > 'PMBUS_REGULATOR("vout", 0)'. Apparently so far no one took offence
> > if a regulator was named "vout0" even if "vout1" didn't exist.
> > 
> > I don't really have a good solution right now, but I guess we'll need
> > a second set of macros for the single-regulator case, or maybe generate
> > struct regulator_desc arrays using a function. I'll have to explore
> > options.
> > 
> > Please let me know how you want the subsystem to handle existing
> > single-channel regulators with numbered regulator name.
> > 
> > Saravanan - for this driver please just declare a local driver-specific
> > variant of the PMBUS_REGULATOR_STEP() macro which doesn't use indexing,
> > use it to initialise a second regulators_desc array, and use that second
> > array for mpq2286. That is a bit messy, but acceptable for now until
> > there is a more generic solution (unless of course you have an idea for
> > one and want to implement it, but that is not a requirement).
> Hello Guenter,
> 
> Thanks for your proposal as intermediate fix local declaration of macro,
> could you please suggest whether below changes is acceptable as workaround?
> 

No, because that would overwrite a data structure which might be needed
by another mpq7932 in the system. mpq7932_regulators_desc should really
be declared const to clarify that it is not supposed to be changed.

Thinking more about it, the solution is actually quite simple. Please add
a second patch adding PMBUS_REGULATOR_STEP_ONE() and PMBUS_REGULATOR_ONE()
macros to drivers/hwmon/pmbus/pmbus.h and use the new macro in this patch.
That would result in code such as

static const struct regulator_desc mpq7932_regulators_desc_one[] = {
        PMBUS_REGULATOR_STEP_ONE("buck", MPQ7932_N_VOLTAGES,
				 MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
};

...

        if (info->num_regulators == 1)
                info->reg_desc = mpq7932_regulators_desc_one;
        else
                info->reg_desc = mpq7932_regulators_desc;

We can then use the xxx_ONE macros when adding regulator support to existing
or new drivers, and either keep existing drivers as-is or update them based
on DT maintainer input.

Thanks,
Guenter
