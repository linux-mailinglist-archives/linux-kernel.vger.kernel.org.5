Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBC8079E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjLFU63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjLFU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:58:28 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4A1A5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:58:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be10acaf9so272589e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701896311; x=1702501111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkBTFydFN1nOSzt1n3Rcusw0wfyqULgHkbuf/PZSmKs=;
        b=u0eAYeqIhbe/rA1Lo4nDnm0RBi6nWm0/IYD6WEbWO68zibTH1SStvAO4sjGVZ/djcq
         MBSXsACH4PdSUk8n0oeRmRItEtOBxsrJ+mrNcid+meii/NtV2A3w1h1nAa/CcOjcKS/e
         3yUXJC64w7wYnmlBV28GKOCC2paB4RNlcil6ZtaWUnnl9+AiajopsS7fvugTHxYoo5Rn
         ApyWXOEXiyr+6MLf3yPMiQLLJqZyiMvoB7BG3nDwyFPjJEYktwwWZqTDbRJK7KiTKdb/
         cfH/pBR0tqhEXN3vSwPYVSiFr58kBhI7jIS8QGIsLKq6yi4ttSmfZTIfnpV8QefAgA7p
         HM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896311; x=1702501111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkBTFydFN1nOSzt1n3Rcusw0wfyqULgHkbuf/PZSmKs=;
        b=lpfJGw1b1kYSshOXnQAYNJrbs1MLnqyExfripGKjPiO62Mo0WbwASpvIycJt3uXhK3
         EVNzZqYeLOHJ2e1oYHrgwa0pW03X9KAqjHDENrJUJYBdXtgfZ+ZOGWaW1fOv9Tmhj4wI
         tlxQp85AsOPf6H7qQnmc/nKBi/SVpp/fN5ecu0alG1FFWG8Ib6CPVRgMHvzXQUJkT0Cs
         WpGx/yj6fWqCmx7uJspbzbtLRzXB6BsOLzvXWr2mIdKURFg6fyMxPck/MxDA0oDxNuSb
         VbjSPQ1kGScB+A/B7KE1f1focz6OCdU/YaZ3KHTzadrsbltSjm6aFNiBZ3v05ruzxGRL
         Zdww==
X-Gm-Message-State: AOJu0YyJCTQIqvy9w8zo9mH3B/c6gqz+LAXJVVCZYsaQ/vcGkim54HPk
        8ya8oYBXwFsChJGO1CKYNRXCcjeGOXUeNHxPdts=
X-Google-Smtp-Source: AGHT+IFTNDQW2rib02jc7CQw8isgEbt5aN4TJbPLvy4HkaAkT3eMJ8mpiMj6cBZIaRTQ2B/WpzMAiQ==
X-Received: by 2002:a05:6512:ac7:b0:50b:f038:16f2 with SMTP id n7-20020a0565120ac700b0050bf03816f2mr3063941lfu.6.1701896310846;
        Wed, 06 Dec 2023 12:58:30 -0800 (PST)
Received: from debian (c83-248-56-68.bredband.tele2.se. [83.248.56.68])
        by smtp.gmail.com with ESMTPSA id g34-20020a0565123ba200b0050c05ad6252sm581412lfv.283.2023.12.06.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:58:29 -0800 (PST)
Date:   Wed, 6 Dec 2023 21:58:27 +0100
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     =?iso-8859-1?Q?F=E9lix_Pi=E9dallu?= <felix@piedallu.me>
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        hkallweit1@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re:
Message-ID: <ZXDgczrh7GznTOj2@debian>
References: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
 <20231205102039.2917039-1-felix@piedallu.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205102039.2917039-1-felix@piedallu.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > So there is a gap in the revisions. Maybe a B2 exists?
> 
> Actually, probably not. Some search gives this datasheet:
> 
> https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/DataSheets/LAN8670-1-2-Data-Sheet-60001573.pdf
> 
> And page 2 (table 1) shows only revisions A0 (rev0), B1, (rev2), C1 (rev4).
> Not sure about why only even revision numbers are released ?
> 
> Page 193 (table 10-1) also shows only B1 and C1. So you can be confident that only those exist.
> 

Thanks for clearing that up!

> @Ramón, thank you for your work on this driver!

Much appreciated
R
