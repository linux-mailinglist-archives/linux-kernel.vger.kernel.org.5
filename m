Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7F57824C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjHUHp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjHUHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:45:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDF2B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:45:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5657ca46a56so525665a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692603955; x=1693208755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JatILT8l8vU5uaY93FjgQ+V4CU+ZgdOl49NPz6kWPo=;
        b=PiG4+A1Fyu8T7gw9wldqBbS2vyE6nrc8Riexzk8DreS3oVJxkpg6Otm1nDVuhcYAOy
         DOBA1DLo9UhvvHp0RgeTZqqX9ibSfMHRPfcta6r/m6TbK+/CtxZhmh8Z7GmEBwdjfbht
         AdR7OOe81qiD7mqmcyT8Y4kM5rIgU7abl6IZN6Y5ujmpHbz/Y6B+hs3JYcL85VlLzODe
         gwHVAbso1SGsLeVnfA/KUH+3OlXhsxnIoq7emePy6E2ZAEYO03HmijmkADlj0YD9si+P
         L2PNQNcWQbgM5I1pHoGyL9rzIiIi/eYDSBuIj9x/ai7+eBEnneTZKgdrnmdrDuNx6Aln
         +4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603955; x=1693208755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JatILT8l8vU5uaY93FjgQ+V4CU+ZgdOl49NPz6kWPo=;
        b=X/aAynqsWCfAUL2ToITV8/E59y4GE+ookFMNROMttekYia+VIS+p4JQBAz5gCn/aOU
         2a8zb6X2NRkZPXRnTc9AqbPyDDncxCSxSV3huUJ/cM2rFWExYVaZC4uP2yIILBfAhYLm
         i7dkkCi4WmDLZe8HJlIHgpv2WnUt8fTQ9MVmNzF1kQFeSaSv0Majn2/B4552T0sl/zAb
         KcoZRcDhfjcd7AloqjMZzJicw8BDm7n3ArEiedYvRl8sDv9Y8yim0UbNHGTGPCkcz2Xs
         Ao8IX/jwIZjrbPoFZgIRuufdsZ272NvULGkduYFFw75jRMOHmFPhxjBlDq/7ytXSFCSy
         eZJQ==
X-Gm-Message-State: AOJu0Yw8mfFo5pUuamVV3EeDjTDSWKsbvtaSOCekuA/+BsBWDtR4Wr14
        9MkDFRcmGi8lQLb8r41UdAQ=
X-Google-Smtp-Source: AGHT+IE1ASKPeoJ4AKqXgxZW2cAcu80pLjrgaAGnVV894dy3rMZCRQ4LWdYPFGlZQ4B6WqBMD1hzOQ==
X-Received: by 2002:a17:902:e743:b0:1be:f087:7fbf with SMTP id p3-20020a170902e74300b001bef0877fbfmr7229006plf.3.1692603955036;
        Mon, 21 Aug 2023 00:45:55 -0700 (PDT)
Received: from mail.google.com (125-237-52-155-fibre.sparkbb.co.nz. [125.237.52.155])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001b89536974bsm6342753plf.202.2023.08.21.00.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:45:54 -0700 (PDT)
Date:   Mon, 21 Aug 2023 19:45:49 +1200
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     masahiroy@kernel.org, bgray@linux.ibm.com, n.schier@avm.de,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] [next] initramfs: Parse KBUILD_BUILD_TIMESTAMP as UTC
 date
Message-ID: <ZOMWLeftCkxx3JgW@mail.google.com>
References: <ZMSdUS37BD5b/dn7@mail.google.com>
 <98defebbdd3f0be69f76f5e6c3d7b72935f072a9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98defebbdd3f0be69f76f5e6c3d7b72935f072a9.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:32:46AM +1000, Andrew Donnellan wrote:
> > 
> > Parse KBUILD_BUILD_TIMESTAMP date string as UTC so no localtime
> > conversion is done which fixes the edge case aforementioned.
> > 
> > Signed-off-by: Paulo Miguel Almeida
> > <paulo.miguel.almeida.rodenas@gmail.com>
> 
> This should also be documented in Documentation/kbuild/kbuild.rst,
> including a note that you can still use local time if you include the
> timezone specifier.
> 
> Thanks,

Thanks for the review Andrew and Nicolas.

Will send a new patch shortly with the changes requested.

thanks,

- Paulo A.
