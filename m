Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E792770375
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjHDOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjHDOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:47:55 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3282649C5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:47:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bcccbd9365so1434855a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691160470; x=1691765270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqQIoeRe9FkNhi9ugijKBQt/la768uvgsVywzbmfOKs=;
        b=UDJPK1g82+VUkheJ1k9KGdQSLdTRDLlCAHraLHuTx/4JMdou6JZGwc91eweFvMz4+B
         hMk4jYgH2tnI69Pv/oE9cTD6SYWIZtIGdsZIYFK8RR6LkeE0NL1/nIecSD+0BOSRWx8x
         ngOwPgTayQpMbMWPu+7OlOZHj12EnCj6ISwqnFl6JRNoIFhdvQnm0uEWtDxcPahAXvLR
         ZdaGxC2pzCDwlIhTxoPws0gwMy3er1bgnmiuCMUj4Smyoxm87cNdMTqfOllJ4+U5h27d
         3N/GaBlYSktHmG7y19Fb5fCuUzMhcdOfcJMwlAL8hnvwvEakIuk7dRzCMxfvUFI8MMXF
         U2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160470; x=1691765270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqQIoeRe9FkNhi9ugijKBQt/la768uvgsVywzbmfOKs=;
        b=GC5fmyux/eHMtk0TBclJrIXDp0ez006YMFBZ5lVWiE46zRi24M4t5mhrkjMqSZ0KqM
         tRuej2vnqe8h4Do6hXLeW0oYFRc5njaAu33ZWfzEmGxhnAXFPBZmxvCTsPCQTjcbcelm
         /nfgSQx0N5SWtAKiS28MkNZ5UrEyZqCDYKZqESaUpcB8rT4R3BdT2EqW5IXelD0INRiU
         p8w+w9L6bOlaEt/3l2V++7F5vupD11vuQNdIoookQAk3MCBxr7Ld2qzC3QJMBVaGNDfZ
         G8LOfe5iWHxX6ntDEaUbuAH2etcWRx3Og1xT8CuAra1/5yDy0ow5fq6xDOeBFmuKR8H1
         j3ig==
X-Gm-Message-State: AOJu0Yzr0ERJDR2WcODiUcGtNkJrkOk51esZrO5+2RFtPaPNGQ0gJQXv
        7wEYOGLXfybq7mtGKsgsjRteEH0a9l0=
X-Google-Smtp-Source: AGHT+IHidmnEjRp2S4bc5k/9fnHJ51zi2bnqpQo0hYSkcdN9W11z9+2an0iV7gY1rrSC8DXtR/bGhQ==
X-Received: by 2002:a05:6870:d611:b0:1bf:7b3:5116 with SMTP id a17-20020a056870d61100b001bf07b35116mr2340963oaq.47.1691160470165;
        Fri, 04 Aug 2023 07:47:50 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id g20-20020a9d6194000000b006b9d237ea0bsm1178982otk.34.2023.08.04.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:47:49 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:47:44 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <ZM0PkFjWAiTrrpog@alolivei-thinkpadt480s.gru.csb>
References: <ZM0Lmt5Dp/k6iO21@alolivei-thinkpadt480s.gru.csb>
 <5539044a-0d67-43d5-9d75-42c65d616239@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5539044a-0d67-43d5-9d75-42c65d616239@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:33:19PM +0300, Dan Carpenter wrote:
> On Fri, Aug 04, 2023 at 11:30:50AM -0300, Alexon Oliveira wrote:
> > Fixed the following as reported by checkpatch to adhere to the
> > Linux kernel coding-style guidelines.
> > 
> > Changes in v3:
> > - Fixed changelog
> > 
> 
> Nope.  :P
> 

Gosh :(

> > Changes in v2:
> > - Fixed CHECK: line length exceeds 100 columns, noted by Greg KH and Dan Carpenter
> > - Fixed CHECK: Alignment should match open parenthesis
> > - Fixed CHECK: Lines should not end with a '('
> > 
> > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > ---
>   ^^^
> 
> Changes go to under this cut off line here.
> 

My bad. Sending v4 now.

> regards,
> dan carpenter
> 
> 

Thank you.

Alexon Oliveira
