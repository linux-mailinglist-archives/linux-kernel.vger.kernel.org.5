Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432A37FAC11
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjK0UxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjK0Uw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:52:58 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58CD4D;
        Mon, 27 Nov 2023 12:53:05 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d7f665285aso2061255a34.1;
        Mon, 27 Nov 2023 12:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701118384; x=1701723184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkEosB8E4SkXTgPuXYPrquLd200A9U4+Ar3MUq+vaC4=;
        b=nR6SxiGKbcBB9rLazqlSnMVUv3SW4ySzR20LepPuJkaNLVYJQk1z2ThGo3K3TtSWM9
         CIhl7Ep8S+rid23Lw+oRuTHrzAhNa13JkitOULUXgPG6zUjvFsPGP087krmFyQFNnL1Q
         2Jn+MO3DMUcLy8WZS9q1YqKwj9n5mB0IvnbbWElH7j6JlHf3GulTfX3egy0HZpIzewAe
         oYbFdJ+cg3Nh08qAUyM2ceycSYLEPTqYIbntMxAwdconOVcEJVFy7VcyigqII8wUEMRs
         TUWmdPuqQeH8i1Svc8M5+eckzWPm7l3IquuR6RJACVd5PpFQR1o+eNzu0Mfc7STd9hjB
         ynwQ==
X-Gm-Message-State: AOJu0YzHDr0hF2oImVU7gwVBafFrrAr1ZE8Kz1fj3oMIHqPlWb6GIj6d
        t3LG/vA4dWz3O2MAWC72jK/rhRzM/g==
X-Google-Smtp-Source: AGHT+IFqyrD9yiyTTCw6iDLy8Ry50gTDAtxgWGh9Ic18f869OJfSTY9HowoVDP8gn31mlH4Hetd3Lg==
X-Received: by 2002:a05:6870:d85:b0:1ef:781a:1f2e with SMTP id mj5-20020a0568700d8500b001ef781a1f2emr6293506oab.1.1701118384666;
        Mon, 27 Nov 2023 12:53:04 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z19-20020a056870515300b001efce0658e6sm2505038oak.39.2023.11.27.12.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:53:04 -0800 (PST)
Received: (nullmailer pid 3369512 invoked by uid 1000);
        Mon, 27 Nov 2023 20:53:02 -0000
Date:   Mon, 27 Nov 2023 14:53:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     paul.cercueil@analog.com, Michael.Hennerich@analog.com,
        lars@metafoo.de, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] dt-bindings: iio: Add binding documentation for
 AD7091R-8
Message-ID: <20231127205302.GA3354666-robh@kernel.org>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
 <8ce972a3708f7789237c86c44e23cdcb23a35103.1700751907.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce972a3708f7789237c86c44e23cdcb23a35103.1700751907.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:42:21PM -0300, Marcelo Schmitt wrote:
> Add device tree binding documentation for AD7091R-8.

Drop 'binding documentation for ' from the subject. You already said 
that with 'dt-bindings'.

Rob
