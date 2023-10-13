Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4058F7C881A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjJMOyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjJMOyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:54:44 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88ABE;
        Fri, 13 Oct 2023 07:54:42 -0700 (PDT)
Received: from [10.6.0.9] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 2E6502FC0052;
        Fri, 13 Oct 2023 16:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1697208880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUgetVycmc11Sy23hS1geccFjAg3uLc1PoJalbYEo1A=;
        b=J8AgwRiWLaST6rVU1SVH02DPcyjEHDLQmnv1X7wYEohahPt5H29XeiEg3p1zW4epN/5lA8
        38a2KpVUTqkiQTDFKHGdAXklNOvFXvojESrGFHqYNsqVMyrHokFyjBYqNsvqnsY9gBUm0j
        jJVGg9wR/zr874sLYF/SRnmHAmoTv9g=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
Date:   Fri, 13 Oct 2023 16:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Implement per-key keyboard backlight as auxdisplay?
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, ojeda@kernel.org
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-input@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

coming from the leds mailing list I'm writing with Pavel how to best handle 
per-key RGB keyboards.

His suggestion was that it could be implemented as an aux display, but he also 
suggested that I ask first if this fits.

The specific keyboard RGB controller I want to implement takes 6*21 rgb values. 
However not every one is actually mapped to a physical key. e.g. the bottom row 
needs less entries because of the space bar. Additionally the keys are ofc not 
in a straight line from top to bottom.

Best regards,

Werner

