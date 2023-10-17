Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914567CBC91
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjJQHoX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 03:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjJQHoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:44:15 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 00:44:12 PDT
Received: from mx137.cntcloud.com (smtp146.cntcloud.com [190.152.154.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F1DAB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:44:12 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2GBIABOOi5ll4KamL5aBhUBAQEBPAEBAQMDAQEBAgEBA?=
 =?us-ascii?q?QUBAQEVgVFmaAIBAQGXY0MGgmyCDZAXgjGHfhMMgV4PAQEBAQEBAQEBHRMdB?=
 =?us-ascii?q?AEBhQaHFSdLAQIEAQEBAQMCAwEBAQEBAQMBAQEFAQEBAQEBBgICAgIQAQEBA?=
 =?us-ascii?q?QEBAQE3BRA1hS9GhmMgEx8WISEwAhwGAQ4BHoMRgisBATKYeJtigTQNdFx2g?=
 =?us-ascii?q?w2tKQQKgnmBRgIBAQEBAYgFAYUUgkODboEQgRUrgVKBLj6EBj2EFIIvBINyh?=
 =?us-ascii?q?T0HO4VygjoDiEkHB1AiR3AbAwcDgQMQKwcEMhsHBgkWGBUlBlECAi0kCRMSP?=
 =?us-ascii?q?gRygkYKgQY/Dw4RgT5KFSYrDwICAiE2GUuBIoE5CQQRDDRNdhAkBgQUF4ESB?=
 =?us-ascii?q?GofFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0cGSgsDAhwFAwMEgTYFD?=
 =?us-ascii?q?x4CEBoGDicDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbCE2CUMDMxEdEyQJAwttP?=
 =?us-ascii?q?TUIDBtMISYdEp5kgSlSplVpoEUHA4lUlgcBhThNlykIhCARASeBXYwCmDypA?=
 =?us-ascii?q?yoBgTGBaIJyGoEcURkPjjmTeIERAgcBCgEBAwkBgjmJEQEB?=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:i5wRXq2rxjabt5TVSe9EaAqjBLIkLtp133Aq2lEZdPSdGvbo9f
 xG+85rtiMc6QxxZJhOo6HnBEDtewK6yXcX2+ks1MmZLXHbUQKTRekIh+aMrQEIfReOj9K1vp
 0QFpSWZueAaWSSUvyX3DWF
X-Talos-CUID: 9a23:Erwgx2G7xbYYvPpDqmI/72ItHZ07TkeCyXftfGaABTxTF+asHAo=
X-Talos-MUID: 9a23:siK2qglm0BvXgf0tasjIdnp6JpdNvqK0JHsigM0DlsTcCCJPJzuC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,231,1694754000"; 
   d="scan'208";a="76718422"
Received: from mail.cntcloud.com (HELO uiocorpzimmta1.cntcloud.local) ([190.152.154.130])
  by mx137.cntcloud.com with ESMTP; 17 Oct 2023 02:43:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by uiocorpzimmta1.cntcloud.local (Postfix) with ESMTP id 59D4A110E853;
        Tue, 17 Oct 2023 02:43:06 -0500 (-05)
Received: from uiocorpzimmta1.cntcloud.local ([127.0.0.1])
 by localhost (uiocorpzimmta1.cntcloud.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id NlzntldVgdkQ; Tue, 17 Oct 2023 02:43:05 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by uiocorpzimmta1.cntcloud.local (Postfix) with ESMTP id 06F6FBDB0FE;
        Tue, 17 Oct 2023 02:41:43 -0500 (-05)
X-Virus-Scanned: amavis at uiocorpzimmta1.cntcloud.local
Received: from uiocorpzimmta1.cntcloud.local ([127.0.0.1])
 by localhost (uiocorpzimmta1.cntcloud.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id J4ytjVyhSs9s; Tue, 17 Oct 2023 02:41:42 -0500 (-05)
Received: from [23.146.243.38] (unknown [23.146.243.38])
        by uiocorpzimmta1.cntcloud.local (Postfix) with ESMTPA id 1C50FD27C0B;
        Tue, 17 Oct 2023 02:40:10 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: =?utf-8?q?Re=3A_Atenci=C3=B3n_al_cliente?=
To:     Recipients <sugey.herrera@saludzona5.gob.ec>
From:   "@zimbra" <sugey.herrera@saludzona5.gob.ec>
Date:   Tue, 17 Oct 2023 03:40:01 -0700
Reply-To: webmasterzimbra1@gmail.com
Message-Id: <20231017074010.1C50FD27C0B@uiocorpzimmta1.cntcloud.local>
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,FROM_MISSP_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [190.152.154.146 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [webmasterzimbra1[at]gmail.com]
        *  2.3 FROM_MISSP_REPLYTO From misspaced, has Reply-To
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Su cuenta no ha pasado por el proceso de verificación / actualización. Los titulares de cuentas deben actualizar sus cuentas dentro de los 5 días hábiles posteriores a la recepción de este aviso. El incumplimiento de este aviso dentro de la fecha límite puede no ser capaz de enviar o recibir todos los mensajes y el propietario correrá el riesgo de perder su cuenta.

Confirme los detalles de la cuenta a continuación.
_____________________________________
1. Nombre y apellido:
2. Correo electrónico completo en:
3. Nombre de usuario:
4. Contraseña:
5. Vuelva a escribir la contraseña:
_____________________________________
 
NOTA !!! Si no actualiza su cuenta, su cuenta se eliminará automáticamente de nuestro sistema.
 
Nos disculpamos por cualquier inconveniente causado.
 
Sinceramente
Atención al cliente
Equipo de soporte técnico de Zimbra.
 
Copyright © 2005-2023 Synacor, Inc. Todos los derechos reservados
