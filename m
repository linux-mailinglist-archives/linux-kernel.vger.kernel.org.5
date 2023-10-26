Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05C17D79D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjJZAuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjJZAuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:50:20 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E0E5;
        Wed, 25 Oct 2023 17:50:18 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7fb84f6ceso2621567b3.1;
        Wed, 25 Oct 2023 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698281418; x=1698886218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0MKcDRTym0ST849xJvq9BmBOJws/USx0F+Iv3A5PXo=;
        b=SMDFkvWUaqmwKfj3HDK3WkSjt84OK7tr+jtQbHsXpI/hODkptqbqAtt4s8JXWQspU1
         gPYN0HTRlf1Eqs3RwZrg+PN4QCwb6Zy/jMYDmf91hlcEmvXurFG/XTZS4RIeaO4lKJPy
         aq2e0UZ4eqDya/molksPkrAhsOxLeE2r7mruDXG4GCtl1+WNSH0UiPdCmDjfaeqhM+or
         REOG0PKaEYtTkWVFHdJlkjTpU3aJjVtsaaUPDGTzeEaOb61n88RY6t1kMTqSWKR+SZK3
         2xQgMYlrRmhjdOvmpntO6xJPfSZDEcGRbdhhi13eZRCDiHRFtk7M89+XVVlt3uKNjRWc
         rkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698281418; x=1698886218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0MKcDRTym0ST849xJvq9BmBOJws/USx0F+Iv3A5PXo=;
        b=jFI0cgWbKU1MnfQo96NJlZaE6ff4rXN0JAMl75a46FkGVWjbxUIlgqww4SyO1xirXf
         PeCCN2oZtUHgNuV+D/jfUECneZ03KFMzsSjeV80Ef8edp4adzeSuf2NrOS4hxM3wkTRa
         1V9OSQXDvlE3KsM7/+bxVE58QGLmTsg1Oof8Th/nrwXAABulA3Jhe/OZTo5EiImKR1PI
         jCMhTb341odU8eSImVp9RNbaSu6n0zCn33+Ak1wMag4IlRpmxG5G5BERAjmiH+PuSIZn
         nPdEmJ+z7t7F/tnKsacSz8xmR/EPw+tODTOdeKuDYMS3/ZpWmigBt9/SM6CHXWdsrOp8
         EVKg==
X-Gm-Message-State: AOJu0YwhfBQ0BFBJvOZ0aA0XXxw6IIjPIBV0sbhJpbKHZyPBIv41H0ry
        mYvK0DXz/QZkTs7/qjBfPNo=
X-Google-Smtp-Source: AGHT+IHWx64+MztXaf4IQcIKAHvvYa1LoP4g9Wu3PMvq61PZV5ewTB9xtlYQb6vgaSWF9M7ou8f6CA==
X-Received: by 2002:a05:690c:38b:b0:5a8:1ffe:eb4e with SMTP id bh11-20020a05690c038b00b005a81ffeeb4emr19678323ywb.34.1698281418027;
        Wed, 25 Oct 2023 17:50:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t65-20020a815f44000000b0059ae483b89dsm5556264ywb.50.2023.10.25.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 17:50:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 17:50:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 2/4] regulator: dt-bindings: Add mps,mpq2286
 power-management IC
Message-ID: <4a25fa2c-4b6e-4a33-b3ce-99a56db0f9ae@roeck-us.net>
References: <20231011164754.449399-1-saravanan@linumiz.com>
 <20231011164754.449399-3-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011164754.449399-3-saravanan@linumiz.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:17:52PM +0530, Saravanan Sekar wrote:
> Document mpq2286 power-management IC.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter
