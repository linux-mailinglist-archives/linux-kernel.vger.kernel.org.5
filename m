Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD2277AECF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 01:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjHMXIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjHMXIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 19:08:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CEFF4;
        Sun, 13 Aug 2023 16:08:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-688142a392eso2611352b3a.3;
        Sun, 13 Aug 2023 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691968098; x=1692572898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9JlXLORYOfm/q2cOSvkTA1/8DxKwG4dB0F8z/ohih0=;
        b=GzT/obKOYniut1GN02UyxTYS+2wdIDT622SR7dISj5HwueH9ofY6BpHHSIKIc/dVoX
         ujczl8Yd5bVZ/rmRsk5eoS081ygIK8k9YvmL79G8YARDY63WrSWujTmIY3H46QZhvJV5
         2eqxQrol7a1zTh/RVrrKhhoqYd21LRfCdbm0YuGPmvqLcf0r6lMwTRXceN1FzMJY70fS
         IkiHcfCSN6Sw/YJP4yUKX1gn6iLBIU8HMwn0wt11ENMSLTFnrXBnOZ60zNcH/fTpEdCk
         vfZ8Os5pmHl1Y8pHkdfdhyNsH4JqxwxVkh4+O6oS54CXvYVWSc4/zlqvljnEvG448gpK
         sAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691968098; x=1692572898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9JlXLORYOfm/q2cOSvkTA1/8DxKwG4dB0F8z/ohih0=;
        b=FBOgM+O4+IIOJygBYlfccc8pFh1Vpx3+GHyLbxVsKazVb0j85esuleWq9OhCZbF1Df
         n62DN45UtJkICf3YmxmtpkA2XpPMnWPs9uXSM75yBq+9DNBJ6nv+uteSkQd00NvmIdcx
         wpwfAsIkjeTvF2Vin2rXOg5iZRVYFsFRe/PltYQJrG2y1ACVTpH7PYqooC0WbYCkoHID
         r3YRCZalBkOTwZpkwtqxoG7wcmL0nMY6fl8WhP/8Sgo8QIzBVidfu1E1xV5SmElnnzFM
         x+m7Fj5xSjny4CwK+gduxnKfnTRA2elcAg5R8I/mqxbqxwR1fyShc97BxIeinfGeQRpo
         ATmw==
X-Gm-Message-State: AOJu0YwSnEoDjRee9Lda6kq8K6WtVYPrCCLi8mUxUcVfny5ZGE8L8u54
        etUuGaqbYcTqteJ/iZtvBxzjQchRqVE=
X-Google-Smtp-Source: AGHT+IF0LsPqGPLhwbVvkdmWZUIEQvJYG2O23+QYESsxuFdfbXzejj7leRAmMYXMQgWZzKBTibNCDg==
X-Received: by 2002:a05:6a20:144f:b0:137:74f8:62ee with SMTP id a15-20020a056a20144f00b0013774f862eemr12105163pzi.18.1691968098367;
        Sun, 13 Aug 2023 16:08:18 -0700 (PDT)
Received: from localhost ([2600:1700:38c1:1d7f:f66d:4ff:fe3c:3ceb])
        by smtp.gmail.com with ESMTPSA id i25-20020aa78b59000000b006877ec47f82sm6675510pfd.66.2023.08.13.16.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 16:08:17 -0700 (PDT)
Date:   Sun, 13 Aug 2023 16:08:15 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srichara@quicinc.com
Subject: Re: [RESEND,PATCH 1/2] firmware: qcom: scm: Add SDI disable support
Message-ID: <ZNliXwJCO14AGceg@localhost>
References: <20230518140224.2248782-1-robimarko@gmail.com>
 <f62b5cfd-41e5-aad5-04bf-5959b2fd7a51@quicinc.com>
 <CAOX2RU7W+fM0xhbRkF9c8x8uSD1=gWuuU6XHLKA79ZY-mY6JdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU7W+fM0xhbRkF9c8x8uSD1=gWuuU6XHLKA79ZY-mY6JdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 01:16:56PM +0200, Robert Marko wrote:
> On Thu, 18 May 2023 at 16:25, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> > On 5/18/2023 7:32 PM, Robert Marko wrote:
> > > Some SoC-s like IPQ5018 require SDI(Secure Debug Image) to be disabled
> > > before trying to reboot, otherwise board will just hang after reboot has
> > > been issued via PSCI.
> > >
> > > So, provide a call to SCM that allows disabling it.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> >
> > This scm call support indeed needed for reboot cases, but i am not sure
> > about target specific check in the later patch.
> 
> I am not really sure where to put it, maybe as part of qcom_scm_shutdown?

I would suggest not waiting until shutdown. In fact, I suggest the
opposite -- that this needs to be done as early as possible. Any delay
leaves room for hanging the system -- because a watchdog reset, for
instance, might not be able to trigger an shutdown handler.

And I also imagine that's not the complain Mukesh had; I expect his
reservation was about using the SoC compatible property. But I'd prefer
having that conversation on patch 2.

> Yesterday I found out that in OpenWrt we also have a Google IPQ4019 board that
> has been needing SDI to be disabled as well.

That's me [1] :)

Feel free to CC me on such occasions. I would have loved to have
engaged with this earlier. Anyway, I replied directly to patch 2, since
I think that's a more appropriate place for the discussion.

Brian

[1] Subject: [RFC PATCH] firmware: qcom_scm: disable SDI at boot
    https://lore.kernel.org/all/20200721080054.2803881-1-computersforpeace@gmail.com/
