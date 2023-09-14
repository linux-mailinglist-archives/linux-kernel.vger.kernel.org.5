Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1BA7A0BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjINRsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbjINRsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:48:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983271FF6;
        Thu, 14 Sep 2023 10:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNQk+X865tC4Ls01jQIL1lRpHmt3LDX/JTbowdt79P5nAJZQiKrZD3EgM9ABPAe1OTBpE484qEAnZeOwBaxO+1jazaR3+83I4bCcbl/hSi0L2yUjb2B2GfPefzK/9TPEZiXlaUIsT1sGuL/bZmmySfND3RXre/vwfBk8j9rzjRrDq+aMvdlQgS6ISDAsuz4lfZ8kNQ6h7qsKLWzyfXx9VpEnTFCu5n4ZqF5DIYc/KFcQ0voO0X7MkkhwQc1cFQlzyt0OtUwOLT2dTs0H2yYb2l7jHb+l7XXLZoLTB0Mx1EP5v8dPmBxmyJEoAMfOTNu31hw+TgcH970H7HGQs1iNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdTrul6J1XudJV/XwrgQ1gMPcTBFm09fvgKQXsbYnAI=;
 b=nWZL3xZCiLVn9d0eWFn2crmcjzAHXj11OO0NgIsAPzU7iV0N0/QcOwtYtePv6ReU5iZ9T3b5wdg4wknBvXaG0PDsti2TbJcWU7fqZ49BkN3cRJC3AyInMfV2pmsE+y8xGqgxwtvBMnZjE58X1H4aSdUZPaC2NCpOJu63lC6bAsgcEohhoM1Bg53IShSeGfJWgGIHkfWdECuUf10adoA2P6PaYekPdMmM9dTt5RyPzt7pzf6K3QPZJenS5l+UEOmQyK46fG9JZ75u2wGHA0GmZJNEMQx07w7uLwFn/F852T79eqf2J3TQbGdb19VjvO7I4Cga6oXzhOgmRX/5nl/tLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdTrul6J1XudJV/XwrgQ1gMPcTBFm09fvgKQXsbYnAI=;
 b=TthvZbnjGqtXlOyxR9QPyd2Na7/E5VjcibmugkFAqc6sD0qEGnXgeQKSNdMOFIvbtxNB5yC2CIwXiVStnD5uz25C9A59bREAMoSZ8a8evPrj6lfY9cNrNQoLheCY6PuuG7VzaxSWENqM/tkf4vrq/+P+bPwHMonSUjm1UlltWXM=
Received: from MN2PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:d4::34)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 17:48:31 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::28) by MN2PR04CA0021.outlook.office365.com
 (2603:10b6:208:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 17:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 17:48:30 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 14 Sep 2023 12:48:28 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
        <linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 2/2] docs/sp_SP: Add translation of process/embargoed-hardware-issues
Date:   Thu, 14 Sep 2023 12:47:52 -0500
Message-ID: <20230914174752.3091407-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914174752.3091407-1-avadhut.naik@amd.com>
References: <20230914174752.3091407-1-avadhut.naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cdf67b-7805-44e8-00bf-08dbb54acf00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1NsgGQaItJvRs+lwdmTC5JCVvSO0haXKjUFVZv7aATogJR1FVSQMTdHSOpsUlJkpu2xD2U6LNvl1CAm9D/6g72ErUSsrYJODTMh6vpijhf5VmMkK2jpslfC6aahu1+7uI6JO+baW+IuGZGPELonTtkHjWcWW3YhzaV69eFEW7o1z4628duPRg8cLJYyWSN++Ka5ZvetnaO9FbRGkoX6JxY104Dsf63efLnYPUGLflQIlXW07iVb2oSKeqMkcYW8jfPQury8wNoy0KOAHGdiYrirxJKF0AMme0UpPOuQLphAw6ztNawP1Xwyl7QzzYR8JNGDHpWlKTh8m4egQnHNuprpIU/bhj8FegM3Z2Kcni0fy5zDLl2srbD5KAdASe5TU0OhNu+3i4kg6ljr8MmJEpCMmeTgGKfRpC4ql1eU+T4R/OMrblpsgby240s1dB2wqyBV0TY2P6MqaIpIAI4vvYszB+iusV4s5BAagqQQYlvm5B4fbxpgRmR7v6dP4t8hGIiqS0nYshD1c3yt19x8s1n0OwNzOceadAKLKf0+83uolMUDvLLM8+0lAgJfwVwFk/VOd+n3jThhtMgKRxWORASI6WG1FarfJV0FkQj+w1e62s7tbCJEeYxul78PBIFUlUlvS5C72FezHm/bQnirNfcSVW9Ja9mp7+0EfE6F0Wu26qMHDtqG02dOzJej1EWoWR+V6Znx1IVoY02PgxuKyHudIBXQInp1GfYvdEO0efzp4aIY35XUngA8KaPltsr2U1EGCKdnmXUqSWarasEALyHmCQPZdc9oOGF6GSkNLgE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(30864003)(41300700001)(40460700003)(2906002)(66899024)(54906003)(40480700001)(6916009)(316002)(4326008)(36756003)(8676002)(8936002)(44832011)(5660300002)(70206006)(70586007)(45080400002)(7696005)(6666004)(2616005)(1076003)(336012)(16526019)(66574015)(36860700001)(356005)(26005)(82740400003)(81166007)(426003)(478600001)(966005)(86362001)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:48:30.7679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cdf67b-7805-44e8-00bf-08dbb54acf00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/process/embargoed-hardware-issues.rst into
Spanish

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../process/embargoed-hardware-issues.rst     | 341 ++++++++++++++++++
 .../translations/sp_SP/process/index.rst      |   1 +
 2 files changed, 342 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst

diff --git a/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst b/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
new file mode 100644
index 000000000000..c261b428b3f0
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/embargoed-hardware-issues.rst
@@ -0,0 +1,341 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/embargoed-hardware-issues.rst
+:Translator: Avadhut Naik <avadhut.naik@amd.com>
+
+Problemas de hardware embargados
+================================
+
+Alcance
+-------
+
+Los problemas de hardware que resultan en problemas de seguridad son una
+categoría diferente de errores de seguridad que los errores de software
+puro que solo afectan al kernel de Linux.
+
+Los problemas de hardware como Meltdown, Spectre, L1TF, etc. deben
+tratarse de manera diferente porque usualmente afectan a todos los
+sistemas operativos (“OS”) y, por lo tanto, necesitan coordinación entre
+vendedores diferentes de OS, distribuciones, vendedores de hardware y
+otras partes. Para algunos de los problemas, las mitigaciones de software
+pueden depender de actualizaciones de microcódigo o firmware, los cuales
+necesitan una coordinación adicional.
+
+.. _Contacto:
+
+Contacto
+--------
+
+El equipo de seguridad de hardware del kernel de Linux es separado del
+equipo regular de seguridad del kernel de Linux.
+
+El equipo solo maneja la coordinación de los problemas de seguridad de
+hardware embargados. Los informes de errores de seguridad de software puro
+en el kernel de Linux no son manejados por este equipo y el "reportero"
+(quien informa del error) será guiado a contactar el equipo de seguridad
+del kernel de Linux (:doc:`errores de seguridad <security-bugs>`) en su
+lugar.
+
+El equipo puede contactar por correo electrónico en
+<hardware-security@kernel.org>. Esta es una lista privada de oficiales de
+seguridad que lo ayudarán a coordinar un problema de acuerdo con nuestro
+proceso documentado.
+
+La lista esta encriptada y el correo electrónico a la lista puede ser
+enviado por PGP o S/MIME encriptado y debe estar firmado con la llave de
+PGP del reportero o el certificado de S/MIME. La llave de PGP y el
+certificado de S/MIME de la lista están disponibles en las siguientes
+URLs:
+
+  - PGP: https://www.kernel.org/static/files/hardware-security.asc
+  - S/MIME: https://www.kernel.org/static/files/hardware-security.crt
+
+Si bien los problemas de seguridad del hardware a menudo son manejados por
+el vendedor de hardware afectado, damos la bienvenida al contacto de
+investigadores o individuos que hayan identificado una posible falla de
+hardware.
+
+Oficiales de seguridad de hardware
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+El equipo actual de oficiales de seguridad de hardware:
+
+  - Linus Torvalds (Linux Foundation Fellow)
+  - Greg Kroah-Hartman (Linux Foundation Fellow)
+  - Thomas Gleixner (Linux Foundation Fellow)
+
+Operación de listas de correo
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Las listas de correo encriptadas que se utilizan en nuestro proceso están
+alojados en la infraestructura de IT de la Fundación Linux. Al proporcionar
+este servicio, los miembros del personal de operaciones de IT de la
+Fundación Linux técnicamente tienen la capacidad de acceder a la
+información embargada, pero están obligados a la confidencialidad por su
+contrato de trabajo. El personal de IT de la Fundación Linux también es
+responsable para operar y administrar el resto de la infraestructura de
+kernel.org.
+
+El actual director de infraestructura de proyecto de IT de la Fundación
+Linux es Konstantin Ryabitsev.
+
+Acuerdos de no divulgación
+--------------------------
+
+El equipo de seguridad de hardware del kernel de Linux no es un organismo
+formal y, por lo tanto, no puede firmar cualquier acuerdo de no
+divulgación. La comunidad del kernel es consciente de la naturaleza
+delicada de tales problemas y ofrece un Memorando de Entendimiento en su
+lugar.
+
+Memorando de Entendimiento
+--------------------------
+
+La comunidad del kernel de Linux tiene una comprensión profunda del
+requisito de mantener los problemas de seguridad de hardware bajo embargo
+para la coordinación entre diferentes vendedores de OS, distribuidores,
+vendedores de hardware y otras partes.
+
+La comunidad del kernel de Linux ha manejado con éxito los problemas de
+seguridad del hardware en el pasado y tiene los mecanismos necesarios para
+permitir el desarrollo compatible con la comunidad bajo restricciones de
+embargo.
+
+La comunidad del kernel de Linux tiene un equipo de seguridad de hardware
+dedicado para el contacto inicial, el cual supervisa el proceso de manejo
+de tales problemas bajo las reglas de embargo.
+
+El equipo de seguridad de hardware identifica a los desarrolladores
+(expertos en dominio) que formarán el equipo de respuesta inicial para un
+problema en particular. El equipo de respuesta inicial puede involucrar
+más desarrolladores (expertos en dominio) para abordar el problema de la
+mejor manera técnica.
+
+Todos los desarrolladores involucrados se comprometen a adherirse a las
+reglas del embargo y a mantener confidencial la información recibida. La
+violación de la promesa conducirá a la exclusión inmediata del problema
+actual y la eliminación de todas las listas de correo relacionadas.
+Además, el equipo de seguridad de hardware también excluirá al
+delincuente de problemas futuros. El impacto de esta consecuencia es un
+elemento de disuasión altamente efectivo en nuestra comunidad. En caso de
+que ocurra una violación, el equipo de seguridad de hardware informará a
+las partes involucradas inmediatamente. Si usted o alguien tiene
+conocimiento de una posible violación, por favor, infórmelo inmediatamente
+a los oficiales de seguridad de hardware.
+
+Proceso
+^^^^^^^
+
+Debido a la naturaleza distribuida globalmente del desarrollo del kernel
+de Linux, las reuniones cara a cara hacen imposible abordar los
+problemas de seguridad del hardware. Las conferencias telefónicas son
+difíciles de coordinar debido a las zonas horarias y otros factores y
+solo deben usarse cuando sea absolutamente necesario. El correo
+electrónico encriptado ha demostrado ser el método de comunicación más
+efectivo y seguro para estos tipos de problemas.
+
+Inicio de la divulgación
+""""""""""""""""""""""""
+
+La divulgación comienza contactado al equipo de seguridad de hardware del
+kernel de Linux por correo electrónico. Este contacto inicial debe
+contener una descripción del problema y una lista de cualquier hardware
+afectado conocido. Si su organización fabrica o distribuye el hardware
+afectado, le animamos a considerar también que otro hardware podría estar
+afectado.
+
+El equipo de seguridad de hardware proporcionará una lista de correo
+encriptada específica para el incidente que se utilizará para la discusión
+inicial con el reportero, la divulgación adicional y la coordinación.
+
+El equipo de seguridad de hardware proporcionará a la parte reveladora una
+lista de desarrolladores (expertos de dominios) a quienes se debe informar
+inicialmente sobre el problema después de confirmar con los
+desarrolladores que se adherirán a este Memorando de Entendimiento y al
+proceso documentado. Estos desarrolladores forman el equipo de respuesta
+inicial y serán responsables de manejar el problema después del contacto
+inicial. El equipo de seguridad de hardware apoyará al equipo de
+respuesta, pero no necesariamente involucrandose en el proceso de desarrollo
+de mitigación.
+
+Si bien los desarrolladores individuales pueden estar cubiertos por un
+acuerdo de no divulgación a través de su empleador, no pueden firmar
+acuerdos individuales de no divulgación en su papel de desarrolladores
+del kernel de Linux. Sin embargo, aceptarán adherirse a este proceso
+documentado y al Memorando de Entendimiento.
+
+La parte reveladora debe proporcionar una lista de contactos para todas
+las demás entidades ya que han sido, o deberían ser, informadas sobre el
+problema. Esto sirve para varios propósitos:
+
+ - La lista de entidades divulgadas permite la comunicación en toda la
+   industria, por ejemplo, otros vendedores de OS, vendedores de HW, etc.
+
+ - Las entidades divulgadas pueden ser contactadas para nombrar a expertos
+   que deben participar en el desarrollo de la mitigación.
+
+ - Si un experto que se requiere para manejar un problema es empleado por
+   una entidad cotizada o un miembro de una entidad cotizada, los equipos
+   de respuesta pueden solicitar la divulgación de ese experto a esa
+   entidad. Esto asegura que el experto también forme parte del equipo de
+   respuesta de la entidad.
+
+Divulgación
+"""""""""""
+
+La parte reveladora proporcionará información detallada al equipo de
+respuesta inicial a través de la lista de correo encriptada especifica.
+
+Según nuestra experiencia, la documentación técnica de estos problemas
+suele ser un punto de partida suficiente y es mejor hacer aclaraciones
+técnicas adicionales a través del correo electrónico.
+
+Desarrollo de la mitigación
+"""""""""""""""""""""""""""
+
+El equipo de respuesta inicial configura una lista de correo encriptada o
+reutiliza una existente si es apropiada.
+
+El uso de una lista de correo está cerca del proceso normal de desarrollo
+de Linux y se ha utilizado con éxito en el desarrollo de mitigación para
+varios problemas de seguridad de hardware en el pasado.
+
+La lista de correo funciona en la misma manera que el desarrollo normal de
+Linux. Los parches se publican, discuten y revisan y, si se acuerda, se
+aplican a un repositorio git no público al que solo pueden acceder los
+desarrolladores participantes a través de una conexión segura. El
+repositorio contiene la rama principal de desarrollo en comparación con
+el kernel principal y las ramas backport para versiones estables del
+kernel según sea necesario.
+
+El equipo de respuesta inicial identificará a más expertos de la
+comunidad de desarrolladores del kernel de Linux según sea necesario. La
+incorporación de expertos puede ocurrir en cualquier momento del proceso
+de desarrollo y debe manejarse de manera oportuna.
+
+Si un experto es empleado por o es miembro de una entidad en la lista de
+divulgación proporcionada por la parte reveladora, entonces se solicitará
+la participación de la entidad pertinente.
+
+Si no es así, entonces se informará a la parte reveladora sobre la
+participación de los expertos. Los expertos están cubiertos por el
+Memorando de Entendimiento y se solicita a la parte reveladora que
+reconozca la participación. En caso de que la parte reveladora tenga una
+razón convincente para objetar, entonces esta objeción debe plantearse
+dentro de los cinco días laborables y resolverse con el equipo de
+incidente inmediatamente. Si la parte reveladora no reacciona dentro de
+los cinco días laborables, esto se toma como un reconocimiento silencioso.
+
+Después del reconocimiento o la resolución de una objeción, el experto es
+revelado por el equipo de incidente y se incorpora al proceso de
+desarrollo.
+
+Lanzamiento coordinado
+""""""""""""""""""""""
+
+Las partes involucradas negociarán la fecha y la hora en la que termina el
+embargo. En ese momento, las mitigaciones preparadas se integran en los
+árboles de kernel relevantes y se publican.
+
+Si bien entendemos que los problemas de seguridad del hardware requieren
+un tiempo de embargo coordinado, el tiempo de embargo debe limitarse al
+tiempo mínimo que se requiere para que todas las partes involucradas
+desarrollen, prueben y preparen las mitigaciones. Extender el tiempo de
+embargo artificialmente para cumplir con las fechas de discusión de la
+conferencia u otras razones no técnicas está creando más trabajo y carga
+para los desarrolladores y los equipos de respuesta involucrados, ya que
+los parches necesitan mantenerse actualizados para seguir el desarrollo en
+curso del kernel upstream, lo cual podría crear cambios conflictivos.
+
+Asignación de CVE
+"""""""""""""""""
+
+Ni el equipo de seguridad de hardware ni el equipo de respuesta inicial
+asignan CVEs, ni se requieren para el proceso de desarrollo. Si los CVEs
+son proporcionados por la parte reveladora, pueden usarse con fines de
+documentación.
+
+Embajadores del proceso
+-----------------------
+
+Para obtener asistencia con este proceso, hemos establecido embajadores
+en varias organizaciones, que pueden responder preguntas o proporcionar
+orientación sobre el proceso de reporte y el manejo posterior. Los
+embajadores no están involucrados en la divulgación de un problema en
+particular, a menos que lo solicite un equipo de respuesta o una parte
+revelada involucrada. La lista de embajadores actuales:
+
+  ============= ========================================================
+  AMD		Tom Lendacky <thomas.lendacky@amd.com>
+  Ampere	Darren Hart <darren@os.amperecomputing.com>
+  ARM		Catalin Marinas <catalin.marinas@arm.com>
+  IBM Power	Anton Blanchard <anton@linux.ibm.com>
+  IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
+  Intel		Tony Luck <tony.luck@intel.com>
+  Qualcomm	Trilok Soni <tsoni@codeaurora.org>
+  Samsung	Javier González <javier.gonz@samsung.com>
+
+  Microsoft	James Morris <jamorris@linux.microsoft.com>
+  Xen		Andrew Cooper <andrew.cooper3@citrix.com>
+
+  Canonical	John Johansen <john.johansen@canonical.com>
+  Debian	Ben Hutchings <ben@decadent.org.uk>
+  Oracle	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
+  Red Hat	Josh Poimboeuf <jpoimboe@redhat.com>
+  SUSE		Jiri Kosina <jkosina@suse.cz>
+
+  Google	Kees Cook <keescook@chromium.org>
+
+  LLVM		Nick Desaulniers <ndesaulniers@google.com>
+  ============= ========================================================
+
+Si quiere que su organización se añada a la lista de embajadores, por
+favor póngase en contacto con el equipo de seguridad de hardware. El
+embajador nominado tiene que entender y apoyar nuestro proceso
+completamente y está idealmente bien conectado en la comunidad del kernel
+de Linux.
+
+Listas de correo encriptadas
+----------------------------
+
+Usamos listas de correo encriptadas para la comunicación. El principio de
+funcionamiento de estas listas es que el correo electrónico enviado a la
+lista se encripta con la llave PGP de la lista o con el certificado S/MIME
+de la lista. El software de lista de correo descifra el correo electrónico
+y lo vuelve a encriptar individualmente para cada suscriptor con la llave
+PGP del suscriptor o el certificado S/MIME. Los detalles sobre el software
+de la lista de correo y la configuración que se usa para asegurar la
+seguridad de las listas y la protección de los datos se pueden encontrar
+aquí: https://korg.wiki.kernel.org/userdoc/remail.
+
+Llaves de lista
+^^^^^^^^^^^^^^^
+
+Para el contacto inicial, consulte :ref:`Contacto`. Para las listas de
+correo especificas de incidentes, la llave y el certificado S/MIME se
+envían a los suscriptores por correo electrónico desde la lista
+especifica.
+
+Suscripción a listas específicas de incidentes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+La suscripción es manejada por los equipos de respuesta. Las partes
+reveladas que quieren participar en la comunicación envían una lista de
+suscriptores potenciales al equipo de respuesta para que el equipo de
+respuesta pueda validar las solicitudes de suscripción.
+
+Cada suscriptor necesita enviar una solicitud de suscripción al equipo de
+respuesta por correo electrónico. El correo electrónico debe estar firmado
+con la llave PGP del suscriptor o el certificado S/MIME. Si se usa una
+llave PGP, debe estar disponible desde un servidor de llave publica y esta
+idealmente conectada a la red de confianza PGP del kernel de Linux. Véase
+también: https://www.kernel.org/signature.html.
+
+El equipo de respuesta verifica que la solicitud del suscriptor sea válida
+y añade al suscriptor a la lista. Después de la suscripción, el suscriptor
+recibirá un correo electrónico de la lista que está firmado con la llave
+PGP de la lista o el certificado S/MIME de la lista. El cliente de correo
+electrónico del suscriptor puede extraer la llave PGP o el certificado
+S/MIME de la firma, de modo que el suscriptor pueda enviar correo
+electrónico encriptado a la lista.
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
index 12cb63a6ea65..d6f3ccfb160e 100644
--- a/Documentation/translations/sp_SP/process/index.rst
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -23,3 +23,4 @@
    researcher-guidelines
    contribution-maturity-model
    security-bugs
+   embargoed-hardware-issues
-- 
2.34.1

