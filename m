Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1107730E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHGVE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGVEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:04:25 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0EE5B;
        Mon,  7 Aug 2023 14:04:24 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1bc5acc627dso13714025ad.1;
        Mon, 07 Aug 2023 14:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691442264; x=1692047064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPBytzBoXkM8SqSSVspWR99ekr3CTrS2qhfrVqOaXbk=;
        b=fC1ak0eBcn/DIlla02RD+Q3r+U4MtGukf4tVqRDsuN9aMuZV8yCe7dlV66G2t1TQQp
         ATtDluM9Hd2oirY5rkXc5y99XNvZtsbbeU41QeuO5z42U45zAWSRGfAmkR74t/S8To/o
         8XDG5p9Hd1WylrdFkMzkCOknWfBrQvPw9kWHJ3qmkV6t0PufgDb9UuCR8nMIp8lxK97c
         YijYjypxPiSrqHYqeYiwWqKYUzelpcKTYmxc2KhBLXX52UPPzuhMSVoe/v/N/Fo1araW
         +PUAXE60M2r9zECIk+y+nQ0BI/rgSq0oBKiblCjzkU1llwDXXm31BMJPRb4Vh5jOXLrm
         xXwA==
X-Gm-Message-State: AOJu0Yzfy3gX7/mKl5T0ZUwWZwegxaBHK4uROTRRwZSx07HppISo4Y1c
        767yt8le7AX41aSJWNDGgWzfHg5365M=
X-Google-Smtp-Source: AGHT+IGWdyymJ9nh1oxiWQLjE3SnxLNbyLy57pWpEMcpvGt47jzwM6QMpgGSgSownW23XgA+VaBwmg==
X-Received: by 2002:a17:902:e5cb:b0:1bb:5b88:73da with SMTP id u11-20020a170902e5cb00b001bb5b8873damr9815793plf.61.1691442263601;
        Mon, 07 Aug 2023 14:04:23 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3aca:8f43:1895:4b6c? ([2620:15c:211:201:3aca:8f43:1895:4b6c])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001b8b4730355sm7345677plh.287.2023.08.07.14.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 14:04:23 -0700 (PDT)
Message-ID: <e37e0d80-9ddc-5a36-44a6-22dd0e36bf8d@acm.org>
Date:   Mon, 7 Aug 2023 14:04:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Add support for QEMU
Content-Language: en-US
To:     jeuk20.kim@samsung.com, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
 <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/23 18:37, Jeuk Kim wrote:
>   static const struct pci_device_id ufshcd_pci_tbl[] = {
> +	{ PCI_VENDOR_ID_REDHAT, 0x0013, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>   	{ PCI_VENDOR_ID_SAMSUNG, 0xC00C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },

Does Red Hat agree with using device ID 0x0013 for this purpose? Is it 
guaranteed that this device ID won't be used for any other purpose?

Thanks,

Bart.

