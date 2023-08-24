Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7A78783C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbjHXStb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjHXSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:49:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36AA1BD1;
        Thu, 24 Aug 2023 11:49:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5007616b756so165060e87.3;
        Thu, 24 Aug 2023 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692902961; x=1693507761;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHRS4UEXxu8F0WleFwTDxLVpmIkpw8qRBxsTWoqyCew=;
        b=EzE2YpmXh9abD9+0dqFc9MXO0MNUNQieniyt6V4qvN5TbOLydMBrfnhUzSEiMPK2TG
         HnK8yubCC0Vy5L/1zZm4zNSx/jIloKmOIH9XDItHJ3c8NcFSE/UxNpOyVnG3zeTQO6+9
         /3NzsVVWEcLTRaVv47zkjW25i2/ak6L/uDcjF2hi0o9dMXXuQtTd4Ak3sJuiB819cd9t
         ln7p4IAUV4h4YyIBPdd4rPwNqeDo9XfRAa6klh4o+da6x+z4JKJ/RvkOOPHTMydY4+1Q
         ULpNX1KoZiDUofBobwzMgOFoYucjZsyDzZslglJE98EW7rCRyGVCxN3/8YnEGNW/mjcT
         PGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902961; x=1693507761;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LHRS4UEXxu8F0WleFwTDxLVpmIkpw8qRBxsTWoqyCew=;
        b=I72GuY87bQ67ZhoIZHHuz+aNhF8JbDJi86wvc8uZFeYD9XnvoVUADBcS5KAwnhr2mV
         HmKGjjvDApdZlNJiP4JZpJGf3AoF4dRTwQ/RG069YjAVKVzZq8dArJjAxxfpUkh3zKCn
         IU9EPsl0E+1I+94wsXGHdaGXwFCwc/q29OZ3AUMW4GaWDPxx8Hazro49vWbXE/uhorCO
         2rlZpEn7I4zjlPcWWE05kY9dv+JaflVF2EWkcc9gvltVUVxHstVbFVwyeGVd4ypd4yDF
         lM+ACwZ+mRHFhXkZRqvwAzM/Y6kK6by5ao5DA8ARVCI8a7/JL9eaOAjCGsEz/kL6zAz7
         +zuQ==
X-Gm-Message-State: AOJu0YzeEbNHuWY+s8IaAw/KSvj25A+VBIA9zdn+mGqSiZX0DHqX9yVP
        CpmSxD7HnjNk6JEAi0oaZh8=
X-Google-Smtp-Source: AGHT+IH4UH6SkmpNTWiDNASumNMT3avgYEaJSuF1a/GllfuoDAQfjLNGRgsgsTLHW4a+HgVEswOKCA==
X-Received: by 2002:a05:6512:36c9:b0:4fe:17d6:af2b with SMTP id e9-20020a05651236c900b004fe17d6af2bmr10240267lfs.42.1692902960837;
        Thu, 24 Aug 2023 11:49:20 -0700 (PDT)
Received: from [192.168.100.57] ([77.105.14.121])
        by smtp.gmail.com with ESMTPSA id i9-20020aa7c709000000b0052a198d8a4dsm59792edq.52.2023.08.24.11.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:49:20 -0700 (PDT)
Message-ID: <add84df503df6b0bd3f572cd396dbde9da558eab.camel@gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: marvell: add
 MV88E6361 switch to compatibility list
From:   airat.gl@gmail.com
To:     alexis.lothore@bootlin.com
Cc:     andrew@lunn.ch, davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        olteanv@gmail.com, pabeni@redhat.com, paul.arola@telus.com,
        richardcochran@gmail.com, scott.roberts@telus.com,
        thomas.petazzoni@bootlin.com
Date:   Thu, 24 Aug 2023 20:49:17 +0200
In-Reply-To: <20230517203430.448705-2-alexis.lothore@bootlin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.48.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an error? The new string include 6163 instead of 6361
