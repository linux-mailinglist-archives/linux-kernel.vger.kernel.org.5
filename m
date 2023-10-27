Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA47D906F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbjJ0H5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjJ0H5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:57:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E31AA;
        Fri, 27 Oct 2023 00:57:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698393469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKtr3c2y4bwdF/vP9HE6zYBjusukdEz9+E2VJT4SVls=;
        b=Kz4Oggw8+grS0WSKVO+9MyGnS273ejuWYfJtGOvjd+CrftpUcSKRYKB25UcvePrTyRUlSs
        2P0RuymBweHmZZl5FsV8xqWoBqmdRn0zbK7N8WWtILTzveoXeY2XO84P9T0p5TfUVhx3ay
        wibhPTvzyaD7ZzC3uJcb8H8Mi02++PkV8/EuKoCf/eu6/52Opr2i6yIRSQefcftlng5mRR
        VL4S1IE4ek7Hnn6UnLxbtKlgGQl2cs/U9TrZ8fjUu39NJxOp0Ivjzx9moEIPNNvVd7nWYn
        GAUKA1xDr3RyizeolP4Ma2oL4Wwbahd0nrZt1iWfAFE13FmnUArSmfTp4/51YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698393469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKtr3c2y4bwdF/vP9HE6zYBjusukdEz9+E2VJT4SVls=;
        b=64RmxwlmEIlKoZMqNa2m2RVJYbjNA5l71PuX77/hdLLuwKlQzC6xWex5nFyGrKhx8nwNfY
        DzKX9jc4LGiriABg==
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] of: property: Add fw_devlink support for msi-parent
In-Reply-To: <20231025142820.390238-3-apatel@ventanamicro.com>
References: <20231025142820.390238-1-apatel@ventanamicro.com>
 <20231025142820.390238-3-apatel@ventanamicro.com>
Date:   Fri, 27 Oct 2023 09:57:49 +0200
Message-ID: <871qdg4hvm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25 2023 at 19:58, Anup Patel wrote:
> This allows fw_devlink to create device links between consumers of
> a MSI and the supplier of the MSI.

How is this related to the two fixes in this series?
