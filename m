Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8678E3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjHaADr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344601AbjHaADq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:03:46 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2217CDA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:03:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-564af0ac494so286524a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693440223; x=1694045023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VbAFF+mQ3qo4IqvELdDEKnEePt5q/NF9cOLJ4fQs4c=;
        b=NtTxdPtzChlphLzPyHgbZIRPE8CfMvug72kjB3FwHqjTOmd9myq9J8Tfk2maGVtMSH
         yjhSeihyHNphoN91OLUbGRPekKYBNHwR+yBDLAsLN2wBWUsMJaX3zfiRAH4lRXDrWZ5V
         jT7OhB8gOfuj/vLumSFrnyeecGERkxJtyCN/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693440223; x=1694045023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VbAFF+mQ3qo4IqvELdDEKnEePt5q/NF9cOLJ4fQs4c=;
        b=Np7q3ct3tTXvAguJNfbsoV6UOK3G7/Cne/V1dx8/Vwrl1gYuE2ZJo360z1ZdU8iTPN
         z6NLeuJUBRk7VOXWsr5kFWe1wSYqogp5KfVXrXvvUaZiIyanQrIXDq0DT6GkfyvsLKab
         //jqDQYQ4hhpfmC9mIJeH28KTDAAitq5lRtgJ7ysSpmwv7/YTGkP82h2CMBXJ3GJSvV0
         LXPzcVEMCl5qyhIv3sXaP95e52YXzvWmPN/NwK+xcq9aMHCryqTC0wRyo5OMJr09JHmK
         dMyfevXTITH5Q0/IrWpbNuqzPzb23XzWclo5EkaYQ4EeltoGMXcx633+c7Zg+34py4mQ
         j4NQ==
X-Gm-Message-State: AOJu0YxfsU25yTcK54zLXBxD0QQdFJgVYN8YOX6p4Av9eI3rCTaCilIp
        5GzEWsxdMjjxrVqV4msfzbAg0A==
X-Google-Smtp-Source: AGHT+IGzXuhNKvCDESQE2QRrtYZBrvFQDlCXvQaZKzcZ7GFJqvb5A0aJYkymW5POHQPY6ycQWRimsg==
X-Received: by 2002:a17:90a:fa88:b0:26f:4685:5b66 with SMTP id cu8-20020a17090afa8800b0026f46855b66mr3639939pjb.8.1693440223411;
        Wed, 30 Aug 2023 17:03:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ft15-20020a17090b0f8f00b002684b837d88sm152885pjb.14.2023.08.30.17.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 17:03:42 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:03:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: Show Kconfig fragments in "help"
Message-ID: <202308301702.4EB6F55@keescook>
References: <20230825194329.gonna.911-kees@kernel.org>
 <CAK7LNATcTw+btQVri7SBA8gFbDNMYz7D2gMQaoZp9sQGFjCw8Q@mail.gmail.com>
 <87ttsjlmho.fsf@mail.lhotse>
 <ZO2NVLipjlzIh0YS@bergen.fjasle.eu>
 <CAK7LNARjsB+LTBGRfWX68Ld7oehhuBv9SY8scoC=Xk8EJc-OHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARjsB+LTBGRfWX68Ld7oehhuBv9SY8scoC=Xk8EJc-OHw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 11:57:19PM +0900, Masahiro Yamada wrote:
> The attached patch will work too.
> 
> I dropped the "in the first line" restriction
> because SPDX might be placed in the first line
> of config fragments.

Good call. Yes, this looks excellent; thank you! Do you want to send a
formal patch? Please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
