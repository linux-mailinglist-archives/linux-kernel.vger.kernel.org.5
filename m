Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA77CA229
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjJPIqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjJPIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:46:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AEBED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:46:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40537481094so43315425e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697446004; x=1698050804; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bx+1uK2uxz3AS67pDvs9fEtJH4P6/YIs+6GQTjHy+3o=;
        b=HmYQSyZLFjtazJymlFDN2MQCBcnB7qnsEw2l3ofjG6tMad1ul8Qrf1vFaCeoRSUaIF
         y2YOyCidFlSIF4Kzp+Y0qeia8LeU5Lptzd1gCqFY+wt9ZPA5sz4YkoAC6yCCa/LLleZ5
         0j+kbQuLFlJDl3g02k+UuLBh15ELyVai9gpczLhrGf0M6fJgRcWlVcf5kkxtoeNze4nw
         y8iHF5gxHJC+O7mOOvX7gPMkJLe/dGV5tZct/n+WXwjxJ0uu4ijJWq4AyjMIUW0mCGqp
         LXmCqA3FkBAD5UnSZ9mIns+XxKnCLOOcoQRsbNcqcAiJGsQA4O6dAHLR1aflIn/kpHuS
         BDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697446004; x=1698050804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx+1uK2uxz3AS67pDvs9fEtJH4P6/YIs+6GQTjHy+3o=;
        b=ed/CPBDz5QC4qItSEAXpQCHiILq7iXI8assX+oV4YtEmUMIjqKzM83ZLEwxcOwMvGe
         JwS382AW8sWgv0zrWl/nkEY0FYAKcpZWHC0QwWitJG+DcE9nwpXIGbfnmNMlQw8lyYvf
         kPnfQgbEaRqg1r9hUEeFxuwGvnCDweOhT02oDJAjb6GJR5gI2loPYYSVOp3GXblb9Euy
         3yGXm5KzR0IZ5pXzkR5FTno4PH2LKqXGDSeOWuCUWPmuaBQWCOB1zFE7AaaGOtpuaUC2
         UR17/Opi5GrFucD3LjoXZn3484d629+dzl4oQmbiY2wDXU6d6d2gzkQ8RSVVKbULXlyz
         kWcw==
X-Gm-Message-State: AOJu0YxvlWiOcmcaGmiqa/cqq/eAIJE/M5Gluk4OZ540OvsZ2pNgSBER
        fqkR7epZt71TlYIHjhr+72KuQh51UFJmG4OIj/0=
X-Google-Smtp-Source: AGHT+IHbSH+ngv1Ft6wPqriSn4jqYatRQW5mAGubnMFJ2lflKm991ZfDhR6XdqN6OuXX+kVABk071Q==
X-Received: by 2002:a05:600c:600a:b0:406:eef6:3540 with SMTP id az10-20020a05600c600a00b00406eef63540mr24264663wmb.0.1697446003901;
        Mon, 16 Oct 2023 01:46:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b0040772934b12sm6672102wmq.7.2023.10.16.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:46:43 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:46:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: wlan-ng: remove helper function
 prism2sta_inf_handover()
Message-ID: <d50d6a13-c27c-4e9f-8728-e3ad3e4d94db@kadam.mountain>
References: <ZSkg7y2Y2T3midXB@lab-ubuntu>
 <67d90726-15b9-4d64-87c6-bfbf662cbe81@kadam.mountain>
 <CADFX3ORVXcEBzovdbPawW2SLxcMoraKBmmLuOFkMpnHj=T48qQ@mail.gmail.com>
 <4c29cb7a-3b24-4682-9211-09aff1e01360@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c29cb7a-3b24-4682-9211-09aff1e01360@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:40:57AM +0300, Dan Carpenter wrote:
> On Fri, Oct 13, 2023 at 07:04:56PM +0300, Calvince Otieno wrote:
> > On Fri, Oct 13, 2023 at 3:12 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > On Fri, Oct 13, 2023 at 01:50:23PM +0300, Calvince Otieno wrote:
> > > > prism2sta_inf_handover() function basically calls pr_debug() to print
> > > > a literal string. This can be done by the parent function directly.
> > > >
> > > > Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> > > > ---
> > > > Patch version v2:
> > > >       - Replace pr_debug() utility function with the module specific netdev_dbg()
> > >
> > > This isn't a v2 patch, right?  This patch assumes that we applied the
> > > v1 patch...
> > >
> > > This patch is not white space damaged though so that's good.
> > >
> > > regards,
> > > dan carpenter
> > >
> > >
> > 
> > Hello Dan,
> > Does this response mean that the patch was accepted?
> 
> Ugh...  No, sorry.  I suck at emails.  White space damaged is not good.
> I left out the word not...  :/
> 
> You need to figure out what's going on there.  Some of your patches are
> not white space damaged so sometimes you're doing it right but here the
> spaces were replaced with tabs so it doesn't apply.

Wow...  I absolutely suck at writing emails and *reading emails*.  This
wasn't the white space damaged patch.  This was the okay one.

However you sent a v2 patch in the wrong way.  You just posted a fixup
instead of resending the patch.  You've sent v2 patches before but let
me send you my blog link anyway...

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter
