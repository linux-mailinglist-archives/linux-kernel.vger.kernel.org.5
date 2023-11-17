Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4207EF542
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjKQP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjKQP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:26:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4D610D9;
        Fri, 17 Nov 2023 07:26:42 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c320a821c4so1929869b3a.2;
        Fri, 17 Nov 2023 07:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234801; x=1700839601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddFA885Lew1a2TIxEdkKv5i0KGKf0gF/uEp1+TNXPM0=;
        b=B31NSXJER03zss/suRoC8C303zs8N2sFp5oBVjcVsck/QZ/iM8S0WHPA2jlnAnzCfM
         fj7SA9F0HIU8ayTujLwZorl/Hh7/AfqZCJ9ZQzRb0VpvDmesm/jX6jkXyRKGDCLOyNLr
         jhR2AemYO31/qX2cbs2tTR5nymo4HENwYLQc3nO5VwewjXkPpKHSTSxAYwRestcy0d0x
         kuoocZU9o43Fh6T2pQsy6NNR0H72nYhHXz/63LD8ICRCflReIjEOg9Wom/td7iCfnDiH
         WWJ6/SW+c0O2vZa6ft9DIvt9OZcrSRtIKmjkp5oYmfQ+jLkqHLsPsPiWv1ULY+Hw4mQZ
         RGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234801; x=1700839601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddFA885Lew1a2TIxEdkKv5i0KGKf0gF/uEp1+TNXPM0=;
        b=Gh8Fz97yVdJsmXnqzic/rfZygdKZussZEn+eb6bTH3tsuWVHrpD8As839RkpCUN9Pb
         qcH+lAcJb/Y6UKFIsAbjbEzPiFs3Am1ztNlTx2z49y432e5kNhRUHcbx9eP0Djfv4kh3
         g7BnUmOw7hAuTnsGkzns3TZwNWwQafYVTbH6sUTFeGottkMV0S9/R2PjegcitBDkFMA+
         I6dLlt1VvKL0C5h7FL5ywmH7jN+JVjV2Woj9bqtKxiHtnBQtVfB+kssI9RAohCGjcUio
         u5ZQjUtcldEgmcABlH3IjTo+B+bJUjzpQesVuR1AP0Jfi3jbcAaBe7mvdVzO5JLt2Z/h
         qOkw==
X-Gm-Message-State: AOJu0YxP+nzjchfh4OHdaOZjcSpZyQUPqVLBQRwnw6wTgNi+F5J3Ygk6
        BA5eCqG4iUI2P377ZTsml1I=
X-Google-Smtp-Source: AGHT+IGkJBJDsY3m5GSxybyrpFYcyEdmYPgHhELkWF11rl2pBhQgEbEKLNqgWAWqyowjUa0KQp8WWQ==
X-Received: by 2002:a17:90b:1a8c:b0:27d:ba33:6990 with SMTP id ng12-20020a17090b1a8c00b0027dba336990mr16366785pjb.10.1700234801427;
        Fri, 17 Nov 2023 07:26:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gq17-20020a17090b105100b00283a09df0besm413384pjb.43.2023.11.17.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 07:26:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Nov 2023 07:26:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Yin <peteryin.openbmc@gmail.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (pmbus) Add support for MPS Multi-phase
 mp5990
Message-ID: <68bbb3c3-7bb7-4b8f-bfb2-2fb855a9f67a@roeck-us.net>
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
 <20231113155008.2147090-3-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113155008.2147090-3-peteryin.openbmc@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:50:08PM +0800, Peter Yin wrote:
> Add support for mp5990 device from Monolithic Power Systems, Inc. (MPS)
> vendor. This is a Hot-Swap Controller.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>

Applied together with the first patch of the series.

Guenter
