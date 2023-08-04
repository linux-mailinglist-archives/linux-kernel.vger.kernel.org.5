Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0357705AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjHDQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjHDQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:15:36 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EB1BDD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:15:35 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1bbf7f7b000so1401220fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691165734; x=1691770534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1GBcOIPDeV7tNCVGIazG9k1O0TYrkQLn9asOqSiPhY=;
        b=pb6KmP/w2HARLiYWPpykQOTiAX37A/kdcv1HlxsEFJoMegJBPqjlp2lBhZDg+h7msu
         z3h2C7jj1eiK/09Vv434njdtKgAN8sUORIQTQ19eOftnkXt7Br4rJ5gnIZMG1j4BxKTN
         fANTrnNmC8wUI9aBj1WaqTf9W43XDLzqV8wRyHXAEdF51wbc2afY8zAKVEMxEcODs5Oo
         O+M7N8aYlJmXwQoBRxF156Jb8MOdLpTGwRmlQjaQPwQc3SC3rT3zXM+R+BqYjWp1RsGk
         stfEXy5I/Ho4u1FCz3YupavOR3CznsmJR7+TPbl0J186Fqxc73Ytq3aBcZGcgVVRuDq1
         EaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165734; x=1691770534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1GBcOIPDeV7tNCVGIazG9k1O0TYrkQLn9asOqSiPhY=;
        b=h3huFBwtoWkvjg4148ecIkvVtgXGH8z4W0o8UPQ6iaEt+WURoIhK1sorBVg5Y/CGB0
         jfzoAqluEhXS9Wd11BpT13cBLufvefdzjZyX2dmyQTkiW6D1WAAdedlkoYcq0UHXH18t
         4suatayFNNZ8A8kcMpj2myrd0UGc4cRWg2qNglHIRCUxiC57AFdkmYbq061pnqcRFkjn
         7SFFCrDGmN+TBHwhBd5bGN2nEMz2I4Tj/8Phkt3sD/TsC9MyR8KCK11VTeqqXyxfo6ye
         qgD7HWro4uN1wURDWSosNCaMmGhRWgMtzBrBgJ69wNrb+trYOErr6qVUtx6x4n1RfKUP
         YTpw==
X-Gm-Message-State: AOJu0YzHKuUmTudiePHwgvvJquSIwFfZyZEXTYmxPTqsnXo8jcn3L+GD
        cPognb8wyOEx4qP7lIWyu+U=
X-Google-Smtp-Source: AGHT+IFeD2MztaSvHXhBWgKsJN9DH+0mFgtYZ4uvvYNwKH2CJ9a4KXHoT0MqLhwAGEQZ0xIiYzKSWA==
X-Received: by 2002:a05:6870:ec9e:b0:196:45b7:9385 with SMTP id eo30-20020a056870ec9e00b0019645b79385mr2448663oab.27.1691165734387;
        Fri, 04 Aug 2023 09:15:34 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id dy53-20020a056870c7b500b001bb7cf75f09sm1257980oab.38.2023.08.04.09.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:15:34 -0700 (PDT)
Date:   Fri, 4 Aug 2023 13:15:29 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v4] staging: vme_user: fix check alignment should match
 open parenthesis
Message-ID: <ZM0kIZfPbRnjAIJ9@alolivei-thinkpadt480s.gru.csb>
References: <ZM0QPaWv4lp93rGF@alolivei-thinkpadt480s.gru.csb>
 <a440a7c7-cfb8-478f-baca-af7e4d684ca8@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a440a7c7-cfb8-478f-baca-af7e4d684ca8@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 06:54:58PM +0300, Dan Carpenter wrote:
> On Fri, Aug 04, 2023 at 11:50:37AM -0300, Alexon Oliveira wrote:
> > Fixed warnings and checks as reported by checkpatch to adhere to the
> > Linux kernel coding-style guidelines.
> > 
> > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > ---
> > 
> > Changes in v4:
> > - Fixed changelog again
> > 
> > Changes in v3:
> > - Fixed changelog
> > 
> > Changes in v2:
> > - Fixed CHECK: line length exceeds 100 columns, noted by
> > Greg KH and Dan Carpenter
> > - Fixed CHECK: Alignment should match open parenthesis
> > - Fixed CHECK: Lines should not end with a '('
> 
> There you go.  You managed in the end.  :)
> 

Yay, at last :) Thank y'all for bearing with me. Next commits are going to be more fluid, promise.

> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter
> 

Thank you.

Alexon Oliveira
