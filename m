Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A979D457
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbjILPHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbjILPG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:06:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146EC12E;
        Tue, 12 Sep 2023 08:06:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99de884ad25so751668466b.3;
        Tue, 12 Sep 2023 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531212; x=1695136012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SVEaXl6seBdw5lXAfYjpnfIky9vuZwXvZJhUk0v854=;
        b=cVTwKjUP91g7peGOFwKHi7hqYgdn0xOnQha6lNRMgS5qk4JuN6PNXD7PcqYyIHq+0a
         hCUk1uI70o+rRIDyBK+KEJft9/CmYG045LUEZ3jTCjvxLJWYiRRtEmMX+zYDedIJu4TZ
         GzXiNUcLAXiPpCa4ZNd6mactY61PsOpZDCHBca6JdZ+k73XJV7fYilg/xxjLlnX0BlMp
         f2EuveSPcN+hQiKRdnt5Ry54K23ECSFyPm86t9ESM4z/iCT31axMpyY1dzIj1TUfmsRA
         3MCmwho7LtttmY2jCp8JaSJWw+iRp0zcZU1UoHXVLFzirrYT9AqT42kXbnPyk7rQ6giH
         1wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531212; x=1695136012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SVEaXl6seBdw5lXAfYjpnfIky9vuZwXvZJhUk0v854=;
        b=Mdk6X8Qf3hMZxS07E/SkbqrlkW115NlrxmpArwM6l5cUZDJYUPaYe/DOfowAAbI/4L
         JeVhmGrqG/ye/A4Ry5hOHM8LTgr/aBfUJrAYGNkR5ezx7GtgSmwjcNkEvRQZtJGLpq6T
         CAivPAkVgl3KUFKsGtQzoZWhdvQ+6RtB6w/ce9ZVdAOZ1Biv8K3C9JmpTHkmJqX9mOjG
         G110YsllUsfLe1z8BhjAi5D47816T0sUKJledCeVU/p9ICAc3JXx7II39CY7GXvkwixU
         pMkFy+w9tOjTukJqbhhrs8anuo0YHR5FKKSuR9DqK7qCd4/VdntMjhdvWh64Be8f22dd
         jXZA==
X-Gm-Message-State: AOJu0YxV6W1uyMgCnVtaMZTBz/nfBCxYu9jmi3bZl0dampSIwU4KRjzy
        6owHkPzSuFloGHD6Wnty2A==
X-Google-Smtp-Source: AGHT+IHLpX4KdagfPcshrLUeAqL4UuqhZ/o9aLBP5uIBEM0SWLAfZOUWaE/wLimyaP4MKgywB21+SQ==
X-Received: by 2002:a17:906:9e:b0:9a1:ddb9:6547 with SMTP id 30-20020a170906009e00b009a1ddb96547mr11268179ejc.57.1694531212074;
        Tue, 12 Sep 2023 08:06:52 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906060300b0099ce188be7fsm6962955ejb.3.2023.09.12.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:06:51 -0700 (PDT)
Date:   Tue, 12 Sep 2023 18:06:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Kees Cook' <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <683d7b5f-48b5-492d-8577-0be85bff8d89@p183>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
 <202309080848.60319AF@keescook>
 <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
 <202309080910.44BB7CEF@keescook>
 <e364b36eefa049d8863c1c1001018636@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e364b36eefa049d8863c1c1001018636@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:19:20AM +0000, David Laight wrote:
> ...
> > Okay, can you please split the patch so they can be backported
> > separately? Then I'll get them landed, etc.
> 
> Since the header with just the extra #endif is badly broken on C++
> isn't it best to ensure they get back-ported together?
> So one patch is probably better.

Header guard misplacement is not a bug, file ends with:

	#ifndef __counted_by
	#define __counted_by(m)
	#endif

it is just looks confusing in the diff.
