Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BE27B6745
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbjJCLLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjJCLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:11:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002549E;
        Tue,  3 Oct 2023 04:11:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c136ee106so138500566b.1;
        Tue, 03 Oct 2023 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696331468; x=1696936268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7W0+FNAd0bKF+apzSGi3eLmbgyPXGqlSPHXm3DYDdk=;
        b=OE7oXWIUEVhtc5wttEOPKVWpF2GxGgQYhRvrpEr+sFY/7+ZrjcgEeI2FKvdwYGyEoL
         ub4qOxH5ERj9zveG3A9Z35qZX3w2ZmGDmcWksQPdsh+W0xc+eh5KUzZRgIoe7RdTANKa
         EiSAPnjI0u4YbiUnMxp/nULpmfd+FcA4nqWjNdbC1KCrFZnPhWhZhDsbOdJX4GIMH2NN
         DmBWV4XC/6QBNRjC6I1DTQHcyJReAFztmnI4cldxdHkFNaokTaQoBLl3T8UTUUWJsEWo
         /RhsZuGlt61ztmCtDXOYT85AShoCsyVW0UjA7NBDY3OCKQSHMNkWeWOahVqkNrDRd3+E
         CYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331468; x=1696936268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7W0+FNAd0bKF+apzSGi3eLmbgyPXGqlSPHXm3DYDdk=;
        b=upltrs2vLs5eOdk+7QUMjW0lXK5/43TQUgG/jqq0JQcEWpSiWz4hBe7ArvDpHDo7jB
         ysk0ZR6lJGhEqqwzNp7trB1z6nLOlT4wbwfEbricUKZhZ4e+d7y4KWIisLaa2RFyydve
         65/gXVCynp86kur36dgr7ObuPkPu4OAk8K3l5UK7tszeyVbDC4XCIrTBsoQxj29EfXj8
         6tBFfZ7HKJjho4JSr0R7ks2j2KvDqQjAdORUbmqchZidn+2ewZR4zcCO2I374yx5OJIS
         aWPgJQNhpdGovw7TWOoMcnbOXUOJ+Qdd8vYioifTtWhMDnbYs3jaPi9zTB5zo+9i7L4Z
         RBPQ==
X-Gm-Message-State: AOJu0Yzc3hHc553Ye1jT8XXE7r6aY+eexJFR32jiyDesyHhtvlbFiVIj
        BXrrZ7dnR0fpbD3sKN7ekuA=
X-Google-Smtp-Source: AGHT+IGpL7rYXXpFvChgp1hgvW470XkYGsOOn6oCyYkVvRQZXtWsLD2XJ2Xca/k6HErzAqGiSFEyBg==
X-Received: by 2002:a17:906:19b:b0:9ae:48e7:bac9 with SMTP id 27-20020a170906019b00b009ae48e7bac9mr13846259ejb.52.1696331468192;
        Tue, 03 Oct 2023 04:11:08 -0700 (PDT)
Received: from primary ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id fx13-20020a170906b74d00b009920a690cd9sm889393ejb.59.2023.10.03.04.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:11:07 -0700 (PDT)
Date:   Tue, 3 Oct 2023 07:11:04 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 05/14] USB: typec: tps6598x: Check for EEPROM present
Message-ID: <ZRv2yCIzq30AxnqL@primary>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-6-alkuor@gmail.com>
 <ZRun0+pBJ8n6tMZU@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRun0+pBJ8n6tMZU@kuha.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:34:11AM +0300, Heikki Krogerus wrote:
> On Sun, Oct 01, 2023 at 04:11:25AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > When an EEPROM is present, tps25750 loads the binary configuration from
> > EEPROM. Hence, all we need to do is wait for the device to switch to APP
> > mode
> > 
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> I'm not sure I understand why this needs separate patch, but in any
> case:
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
I will move it to be part of the patch that loads the config patch and enables tps25750

Thanks,
Abdel
> -- 
> heikki

