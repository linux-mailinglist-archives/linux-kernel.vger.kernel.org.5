Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6571578E02D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbjH3UCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbjH3UCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:02:19 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B255583;
        Wed, 30 Aug 2023 12:40:19 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-56c250ff3d3so867397a12.1;
        Wed, 30 Aug 2023 12:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424337; x=1694029137;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CR9I2i6YoovH+Nf5pBi25Hodk4wassi7ylHcTtnLMW8=;
        b=VnxkcJRINgm84OD1hwa2gbqnqBeT0L28grUSdXktN+yZRjiJvLREqo9z7yaNsbMiFV
         swYAB7ckiXpssPNrMi6Com9Rf8NrS830HGburcdiS9tAILqzTaPI+7DH5Cstxsbcz003
         vKnZ5vjZwm657FcwildornPwGyLjhDumV4+wfYFf51rV1Beq1/rS8toFzSAHjo1r7fLt
         FQDD+Bfi76vQhIeelZFPxvo4MbYCs6jveAGBOnBviSpwTDOXqs25A4A1Nnn95yXGD0lE
         Eged4qRrWRltdB/55UV4bRfxOR20ayLiLaHp/M5D8jTCQf8XLCJj4LCFMc/91GtR7ij3
         IHlg==
X-Gm-Message-State: AOJu0YyReSMJnjG0sDOwJ9DwYYmfpHlAdkXzRToLfJwijNqaKW6sF4D9
        Tij5hC8DPOnoeB+NZMxTJlY=
X-Google-Smtp-Source: AGHT+IEMkD7LBhPJ9+HJdISFd6EY9ZjdLrfOHZ66KaPMe+Pg928eKQNzSoNyCNP742Z4ijtOKNh1pw==
X-Received: by 2002:a17:90a:8b18:b0:268:b54:7c13 with SMTP id y24-20020a17090a8b1800b002680b547c13mr915163pjn.9.1693424337129;
        Wed, 30 Aug 2023 12:38:57 -0700 (PDT)
Received: from [172.20.4.71] ([208.98.210.70])
        by smtp.gmail.com with ESMTPSA id i25-20020a633c59000000b0055bf13811f5sm10542568pgn.15.2023.08.30.12.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 12:38:56 -0700 (PDT)
Message-ID: <fd3f2d60-a0e4-4acf-ba1c-3506bc002f94@acm.org>
Date:   Wed, 30 Aug 2023 12:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH -next] scsi: fnic: Remove unused function
 fnic_scsi_host_start/end_tag()
To:     Yang Li <yang.lee@linux.alibaba.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230829010222.33393-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20230829010222.33393-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 18:02, Yang Li wrote:
> The function fnic_scsi_host_start_tag() and fnic_scsi_host_end_tag()
> are not used anywhere, so remove them.

Are you sure? I think the following output shows that these are being
used:

$ git grep -nHEw 'fnic_scsi_host_(start|end)_tag'
drivers/scsi/fnic/fnic_scsi.c:2171: * fnic_scsi_host_start_tag
drivers/scsi/fnic/fnic_scsi.c:2175:fnic_scsi_host_start_tag(struct fnic *fnic, struct scsi_cmnd *sc)
drivers/scsi/fnic/fnic_scsi.c:2192: * fnic_scsi_host_end_tag
drivers/scsi/fnic/fnic_scsi.c:2193: * frees tag allocated by fnic_scsi_host_start_tag.
drivers/scsi/fnic/fnic_scsi.c:2196:fnic_scsi_host_end_tag(struct fnic *fnic, struct scsi_cmnd *sc)
drivers/scsi/fnic/fnic_scsi.c:2262:		tag = fnic_scsi_host_start_tag(fnic, sc);
drivers/scsi/fnic/fnic_scsi.c:2439:		fnic_scsi_host_end_tag(fnic, sc);

Bart.
