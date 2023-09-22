Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0877AB106
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjIVLiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:38:16 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7EFAC;
        Fri, 22 Sep 2023 04:38:10 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7a52a27fe03so890636241.0;
        Fri, 22 Sep 2023 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695382690; x=1695987490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUgX4U1nDqbgagySgU1QRculQUZhCufDpVd955ye1oU=;
        b=O304hvCZw4GTnlNls/jJA8ZymGaROphdIcHrADM67r9GR2wna5oXZxqUQwBCTDTsN/
         iuGQXwUIG2ENvYuZtumVlcXI/zAI7YQ5VCMqLNlakxTqtPt9heJnW41Tc0HQqQCgh9FN
         6ajHRC2+eHrEJmi0dzEB/Z28ouMvHrjkz90KM53x2rE/pqPJOzLpyuA/5z9ExJw5bCV+
         bTslQ00/OJbW+THK5nG1n0xLpFZaeRKxqdyQAzKQFiDsb3lZxPTw018YB/JhbBzuj9c7
         tXuikHcGU8gvq6Ld3nCgM7PWSi9TJpXG54E/3wZgjLCLiBvHvKl12DenndIgLCw4dZK3
         liLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695382690; x=1695987490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUgX4U1nDqbgagySgU1QRculQUZhCufDpVd955ye1oU=;
        b=GVmpp2mjoATWHBZ4CJDBCYEtvMMhkozDlPL+YLhjuraFo09bS0sm75rqcdzmhFPE01
         Es1aUzGsllARzMrxA9YmRcPvp6WVtC2rV9KFXJxUEdfyxmMYa9NWr1Xn7jcUX7F34OAw
         3A7SaFtigpIR1Wjd/QTVpZxw8nv0x4A0C02y4Hz+xnB4eH/luh8iPYxw6uJwJS4mwjvA
         iCivcxaGj3qQkUXeLpTyI7oRvSHzR5zxMCRKM6bSD7ew7AWDT8XFXW4XfPZCXDntxag8
         nYx3n4ccbLW5FKcVj3ETeJT5WwCIXF5LqgtoTb0v5GTKgYUoNf19azE3/ibQraTx21dD
         2Ozw==
X-Gm-Message-State: AOJu0Yw+1rL85vkrJRl6KdYTg4t6KCah7Dks+wO046nrt9sB0ap7dkGc
        UaAZBZakR4TiHeyJaa2JoXj+AMDIctpw6HZeAmPsKgAXUjs=
X-Google-Smtp-Source: AGHT+IGIqGChB6cFXllrHUdzdpIdQVOVkFS2UF0Y14Lbfg8SJ76iH1CyhIQdNFhrHSC5b81fr8ojrgimHPbvL8Dfj8c=
X-Received: by 2002:a05:6102:7ae:b0:452:8452:8a90 with SMTP id
 x14-20020a05610207ae00b0045284528a90mr8260920vsg.0.1695382689830; Fri, 22 Sep
 2023 04:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230922062405.2571850-1-milkfafa@gmail.com> <86729293-ad37-4f2e-bff7-c49d166e02df@xs4all.nl>
In-Reply-To: <86729293-ad37-4f2e-bff7-c49d166e02df@xs4all.nl>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Fri, 22 Sep 2023 19:38:01 +0800
Message-ID: <CADnNmFoXBA7mbs2zNFWOCYaP1TheS50E9vTdSH3uhjea=RuALQ@mail.gmail.com>
Subject: Re: [PATCH v16 0/7] Support Nuvoton NPCM Video Capture/Encode Engine
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     mchehab@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thank you so much for your review and time.

Regards,
Marvin
