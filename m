Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E997076AC93
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjHAJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjHAJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:12:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E05584;
        Tue,  1 Aug 2023 02:10:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso758205266b.0;
        Tue, 01 Aug 2023 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690880941; x=1691485741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkBUsAmLUq7YhhUOQ4WRaKkV3LcWzsjvAGeelgGD4l4=;
        b=IZGPkv5r8wE4IMEsEf7Y0lH8cgbqpgTbPoIXuySgolY9Tq+mQoVK5+Okz+ctGFXwD1
         JjPq+VvAacHujm4gxTs5xYWua1YXsC0SdY4WpKaYMpeg9LkRZMIYqkkOF9psU9Oz7nzS
         TUrRBnXCtnZxVfOo+UpU9xaxBulX9uG3PZUwy5zZQ32euczOSEqLPovFiwpcMJIn+DHS
         Kr8kajmej9C3rniqBCA4dyV2PrJBZ2YEr0huGd97UCMyhfkq1d2jOnwy0XU2DzxifI6A
         Y3445z6po5Dz3V1dhlr5lDmrhugg3O68yNbPDJ5UMLOiWkfa1i/en3PmEpdgDrVN6+Ai
         oiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880941; x=1691485741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkBUsAmLUq7YhhUOQ4WRaKkV3LcWzsjvAGeelgGD4l4=;
        b=c/175ZGrLDSAe3bPBIReNno6p9XmxMWMgAi4wFHKY61sdUUNpwoStEk5z6EpH+IK3C
         QBnEW0jdCIGH3N8eC5pum7Z3zXw6bISzxDmojTqhw22JT8tL/s62p7W15A1g4CVgLPeg
         CiH7Yl4wZvSu5UZVSBkPDB3Cq9LjP/qh1YYP4iJDWNRVnTLPwJfSSpEuaMQfo1prWA91
         4mnugZzUPSD2tc7SwXHIdzMYYJffebIf+8ktfZ5ZqhcNhsN2sLO12imXGyHlSGkjJfKD
         vJEJgvSfRL2MOeb4sCLDgkHiqa7CRbBGGrN7lK73eEU4ZdytCr69MBvz/cQ3LwLqJQFC
         N8Hw==
X-Gm-Message-State: ABy/qLZwf7XC2M6a7vYpRzZcMr1LpZxlAjkKA4SdfRb3pwhVgxZRjCcL
        qf/W7LVD8YXzPdFXsxOaEg0=
X-Google-Smtp-Source: APBJJlEVdIB+36Z+4jiYfcdQeZZFfHRdSGl8GZYK9UI/AT9/05ftbW9b+ZVM85hf0wEsg5B6V2/ojQ==
X-Received: by 2002:a17:906:73db:b0:993:f996:52d5 with SMTP id n27-20020a17090673db00b00993f99652d5mr1986472ejl.25.1690880940892;
        Tue, 01 Aug 2023 02:09:00 -0700 (PDT)
Received: from skbuf ([188.27.184.166])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709064f1a00b0099bd86f9248sm7371960eju.63.2023.08.01.02.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:09:00 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:08:58 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: Re: [PATCH net-next v5] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <20230801090858.4eme7b4mlufy4eva@skbuf>
References: <20230801064815.25694-1-ante.knezic@helmholz.de>
 <20230801064815.25694-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801064815.25694-1-ante.knezic@helmholz.de>
 <20230801064815.25694-1-ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 08:48:15AM +0200, Ante Knezic wrote:
> Fixes XAUI/RXAUI lane alignment errors.
> Issue causes dropped packets when trying to communicate over
> fiber via SERDES lanes of port 9 and 10.
> Errata document applies only to 88E6190X and 88E6390X devices.
> Requires poking in undocumented registers.
> 
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
