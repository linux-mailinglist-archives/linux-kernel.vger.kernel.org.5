Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2932F790833
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjIBONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 10:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjIBONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 10:13:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569910EF;
        Sat,  2 Sep 2023 07:13:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso23087795ad.1;
        Sat, 02 Sep 2023 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693664016; x=1694268816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MWR8yXXtpKuEsZy4kLJfJzxDixTk8R1fNTGvvoydOA=;
        b=NUxsvkN4y8ZEFL6PPzw2g97Y/Z7hMezHV01CZjSAPr4FI9AMxcXbMaQAFXWiSQq6MZ
         NBykmmq5w8J0HFHeZMqRvGnB5m6FZQ9Yq+n+8KJeB70njoP9bDpr9YFAgPZml9ZMkFKM
         xmeuUobTFnoHKH+52og5iPAVoJfOOwmPnUDKkN4kVq81FRqKGya9Wh7OwuJ8mDwhZDQQ
         Y8J9nc5+dbYMZUkSYvj3DFZDHnxchjzG1vUuhz1uztgDzJc8ZyyAdYi05mzjg7FJ1BD/
         DeKTbHFicPpVrRjsHoGMGjWxCk/LVQgyH62qFRoJpuWvGwwiDlIIvDih3jeepjaVVk6D
         UlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693664016; x=1694268816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MWR8yXXtpKuEsZy4kLJfJzxDixTk8R1fNTGvvoydOA=;
        b=D3jHWYjltVEXL1BM04GcH6MggxjYzBTiqz+QRiRjScmAQYEMiMVNBUaoHclkaqvC0v
         DVbyzk1ANXbN0qGr2ZWaD4dXW5bKPicjQahROBzv2AHU7/fN5oRn2zIMSQuJ7MS7VaoY
         uG1rjoY/e2bTbDnLcYWU+zwba+DDhp5BJ9XZPd8Zoxbkt4RQgMcTxUOHh/Q0SPw9V1pu
         /XVgq1twYqx8p+/HMR2xk0fQ5vs9/OMpQGKv6fiy+lRb565548G4OP6eOlE8VLVRW19w
         Y4yQKd49XkAu5UbvSqzzqnDt+g82hqndgRCaeXNIGK6XHDfXGBqIoE3O1v+legwQJGAK
         oGRg==
X-Gm-Message-State: AOJu0Yz1UojTp7kug5VeIUrSbuKHE46N6kz3URMCml7mGtvv0Dk+CZwY
        Pnn2n4MnRZzhW7umtNDwXfdTeE/xCjg=
X-Google-Smtp-Source: AGHT+IHS28RxmLeVYWgp0birWGyzLHWodWvMCn/ALR1BKINwmSQ3Q6NHk/b5UNIMlXzjIeM9ERfieA==
X-Received: by 2002:a17:902:ff01:b0:1c1:fa12:5c1 with SMTP id f1-20020a170902ff0100b001c1fa1205c1mr5257396plj.55.1693664015974;
        Sat, 02 Sep 2023 07:13:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001bb9bc8d232sm4719774pli.61.2023.09.02.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 07:13:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 2 Sep 2023 07:13:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <eaaf8f33-ecf6-4e02-9772-7c4a30eb8957@roeck-us.net>
References: <20230831190731.265099-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831190731.265099-1-Naresh.Solanki@9elements.com>
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

On Thu, Aug 31, 2023 at 09:07:27PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add the DT property 'infineon,en-pin-fixed-level' to
> indicated that the chip EN pin is at fixed level
> or left unconnected(has internal pull-down).
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ----
> Changes in V5:
> - Update pin name to align with datasheet
> Changes in V4:
> - Update property name & description.
> - Update commit message.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Applied to hwmon-next.

Thanks,
Guenter
