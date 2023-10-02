Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB997B4D09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjJBICu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJBICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:02:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6ABF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:02:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so15561404f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696233764; x=1696838564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6nQA+7IdEGVeShtOyMA1surPP+2JRBkHyJxsRPLijQ=;
        b=XDJ5pAXY6YxG3c0+6FlSurhBAfPtUTE71UN+fVHS+NafdGJS7Ces567xuWWa0O4OXs
         uC53stThmn8Q1H96ZvAdAOTCVcwxlMAHxQYNQ+BUEPUumRdegg6XUGmvYklGGEQB3m+Z
         LM7NckrcqMm9AogQwVDLWN6wBV5tR+R/cUxdxTfv9wrCXRv+xduvFmIQwgjIzwGRKhPZ
         qZnrntx9zYXBPY2g3vGtqxT7sMitkECkutbj7hBckhZPN28SHyerVIZCSlU+AITJBwah
         gYT+XPvlEqaQFs3j2vsP4tSyctLCZve8J6p5B3ZXWqY5vw1dMQRQqQxmYgkH4MBvR3oF
         Efiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696233764; x=1696838564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6nQA+7IdEGVeShtOyMA1surPP+2JRBkHyJxsRPLijQ=;
        b=Gsz5d+vBtDXXHkslEivqaQU2MU1zpp9c3JGQ1DqxROvSx+DTb8jeKlUnpJ3mhqgmaZ
         up6PEBCw5MSTFqMcWGvsDgkX5C49Y48yAAEbm9XC512BONXOTy/K28LDtTDDQCA72XhN
         +BfremLeqUJJAYmv/EuZ1tfdSPoHFb7d0GbPg0D4seL0v26YTpMvD+uw6CZs2M/owzxy
         7MVkUCF1/2KiN4bDXiuXj5ILQ3Kwi+k34A3gW0LOBUnEDT62LOT7YH7yyYVr6uv0fq48
         MqKfQwDlzKY9SFI7Te/ntDVr8Lj97UfIuo8shnnCGgrsBGdnx62wK6drL9eYY8UoDxwZ
         IQmQ==
X-Gm-Message-State: AOJu0YwVMGMMhzKc4jociDJcRbrJ2c09vm0N9msqJkDktHbzZTkEQBdY
        Y5uFPR6G7WlKRyfO6oGvThbBNQ==
X-Google-Smtp-Source: AGHT+IG+SIdpkH2w32xvRD5YxMNyd5NqxjZoHzXm9cLdi5kGPZjemkeSqZXoaAiWaNjNYY9xhHEktg==
X-Received: by 2002:a5d:63d2:0:b0:313:e953:65d0 with SMTP id c18-20020a5d63d2000000b00313e95365d0mr10034512wrw.28.1696233763900;
        Mon, 02 Oct 2023 01:02:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k10-20020adfd22a000000b0032320a9b010sm19655680wrh.28.2023.10.02.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 01:02:43 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:02:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: Re: [PATCH v3 01/27] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
Message-ID: <2416fa1b-86f1-40d5-b7b5-5fe85e0a8472@kadam.mountain>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
 <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-1-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:23:06PM -0500, David Lechner wrote:
> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 

Having two from headers kind of messes things up.  The second From is
included in the body of the commit message.

regards,
dan carpenter

