Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D317A66CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjISOfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjISOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:35:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C5BE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:35:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50309daf971so4566595e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695134121; x=1695738921; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSwo4Rgs2AkEpAyPzfx38gwfqLAQTI6EnbFcqaeiLDI=;
        b=kMed8Xc3oZI1tOj+MVffT8dPBJPOW1gC6f/T2gY+KyM17gJyaM69Sk9q5FG7bYA27B
         8/6fcjyXaYQoLUqCSULaDLSOm47ez3OwPV+k6UmGS7ogJsPKaQIObjCXomr1+zfO+rqP
         KI91WDwGfaFzhrbaPPW132Fp21f30qov0iI0H6dbThUB3oSv/wpTYe9FD4u+mmzX+Vxw
         KRiHG8FoYfzZJmqQJhwhRZMXh38uxK7fwTEUoMu6SMs59QgeEV1au07lv69ra/52xJ+A
         ly2CxcI7Gdhfa2rqIfxCM8v8hZd1R+o+NRZa9zfl28igMOzptNu35X0DhuroY2GTgSSB
         tfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695134121; x=1695738921;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RSwo4Rgs2AkEpAyPzfx38gwfqLAQTI6EnbFcqaeiLDI=;
        b=sfRH0a9x/osik0w6vER7N6lrz66Zt2bIAx1kesmdvEz0/1AJly1Ydj6bnWPAwaHt85
         FZpkTkXF6iHy8cbYuLx55dC97/SPZ67PJQKTQG501w+aXYNi72V32gzQajuEvYxK44eY
         iovW0hWOkxVdSk2jLdBZ6b8/aXg2TAA3j8Ji6c9CqzfUljy0Yd9z5agXDoVHAGbZT+c4
         zdRsj37B6J1WZmGqwIIH0czNPV0yvtDZMHndsuzDCwYK+KGBIf75Nwj1bJ5de+KqeCnr
         nH+ZWKNykvUDC79Jb0x/p3cD9NDUaHCWt3r23oObC3Q1L9iSZ0mvYZWEMdYWVWq+kuFK
         SUTQ==
X-Gm-Message-State: AOJu0YxWoBh1cMQeTPMV2a1Ft2vCoROcaOohXZu1c1c7OPuGRocVZOjV
        t2uV1vvg5PxzEvn6CAT9VHO5PQkmrUaGO34y
X-Google-Smtp-Source: AGHT+IFrKY55hjlL8Or0773J6yCuqvDTEl+FpS/inuWO5isi5RLrjechdrfRJ/vlcGxQyAaXHGDFZg==
X-Received: by 2002:ac2:5bc6:0:b0:4fe:8ba8:16a9 with SMTP id u6-20020ac25bc6000000b004fe8ba816a9mr9620361lfn.55.1695134121101;
        Tue, 19 Sep 2023 07:35:21 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cc7:ad00:825b:3a27:d1a6:9970? ([2001:8a0:6cc7:ad00:825b:3a27:d1a6:9970])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003fed9b1a1f4sm226786wmj.1.2023.09.19.07.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 07:35:20 -0700 (PDT)
Message-ID: <9738d3ae-cf69-f2d1-85d5-7fa5ce0e1839@gmail.com>
Date:   Tue, 19 Sep 2023 15:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Coelho?= <andrealbergaria@gmail.com>
Subject: deduzir k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boas professores..tenho uma duvida


0xaa = 0xaabbcc // 0x100^k % 0x100 .

..como posso resolver k?

% -> é resto dividido por 0x100

// é uma divisão inteira  (sem resto)

^ é potencia

(os operadores são operadores python ..linguagem programação)

obrigado

